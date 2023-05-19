module MoviesHelper
    def reset_button
        link_to 'Reset', movies_path(reset: true, actor: nil), method: :get, form: 'movies_search_form', formnovalidate: true
    end
end
