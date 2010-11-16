module ActiveScaffold::Actions
  module Export
    def self.included(base)
      base.before_filter :export_authorized?, :only => [:export]
      base.before_filter :init_session_var

      as_export_plugin_path = File.join(Rails.root, 'vendor', 'plugins', ActiveScaffold::Config::Export.plugin_directory, 'frontends', 'default' , 'views')

      base.add_active_scaffold_path as_export_plugin_path
    end

    def init_session_var
      session[:search] = params[:search] if !params[:search].nil? || params[:commit] == as_('Search')
    end

    # display the customization form or skip directly to export
    def show_export
      export_config = active_scaffold_config.export
      respond_to do |wants|
        wants.html do
          render(:partial => 'show_export', :layout => true)
        end
        wants.js do
          render(:partial => 'show_export', :layout => false)
        end
      end
    end

    # if invoked directly, will use default configuration
    def export
      export_config = active_scaffold_config.export
      if params[:export_columns].nil?
        export_columns = {}
        export_config.columns.each { |col|
          export_columns[col.name.to_sym] = 1
        }
        options = {
          :export_columns => export_columns,
          :full_download => export_config.default_full_download.to_s,
          :delimiter => export_config.default_delimiter,
          :skip_header => export_config.default_skip_header.to_s
        }
        params.merge!(options)
      end

      # this is required if you want this to work with IE
      if request.env['HTTP_USER_AGENT'] =~ /msie/i
        response.headers['Pragma'] = "public"
        response.headers['Cache-Control'] = "no-cache, must-revalidate, post-check=0, pre-check=0"
        response.headers['Expires'] = "0"
      end

      response.headers['Content-type'] = Mime::CSV
      response.headers['Content-Disposition'] = "attachment; filename=#{export_file_name}"

      export_columns = export_config.columns.reject { |col| params[:export_columns][col.name.to_sym].nil? }
      includes_for_export_columns = export_columns.collect{ |col| col.includes }.flatten.uniq.compact
      self.active_scaffold_includes.concat includes_for_export_columns

      fcsv_options = csv_export_options(export_config, export_columns)

      # start streaming output
      render :text => proc { |response, output|
        find_items_for_export do |records|
          output.write(generate_csv(records, fcsv_options, export_columns))
          params[:skip_header] = 'true' # skip header on the next run
        end
      }
    end

    protected
    def generate_csv(records, fcsv_options, export_columns)
      FasterCSV.generate(fcsv_options) do |csv|
        csv << fcsv_options[:headers] unless params[:skip_header] == 'true'
        records.each do |record|
          csv << export_columns.map { |c| get_export_column_value(record, c) }
        end
      end
    end

    def csv_export_options(export_config, export_columns)
      {
        :row_sep => "\n",
        :col_sep => params[:delimiter],
        :force_quotes => export_config.force_quotes,
        :headers => export_columns.collect { |column| format_export_column_header_name(column) }
      }
    end

    # The actual algorithm to do the export
    def find_items_for_export(&block)
      find_options = { :sorting =>
        active_scaffold_config.list.user.sorting.nil? ?
          active_scaffold_config.list.sorting : active_scaffold_config.list.user.sorting
      }
      params[:search] = session[:search]
      do_search rescue nil
      params[:segment_id] = session[:segment_id]
      do_segment_search rescue nil

      if params[:full_download] == 'true'
        find_page(find_options).pager.each do |page|
          yield page.items
        end
      else
        find_options.merge!({
          :per_page => active_scaffold_config.list.user.per_page,
          :page => active_scaffold_config.list.user.page
        })
        yield find_page(find_options).items
      end
    end

    # The default name of the downloaded file.
    # You may override the method to specify your own file name generation.
    def export_file_name
      "#{self.controller_name}.csv"
    end

    # The default security delegates to ActiveRecordPermissions.
    # You may override the method to customize.
    def export_authorized?
      authorized_for?(:action => :read)
    end
  end
end
