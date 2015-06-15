module ExamplesHelper
  def example(pen_id)
    content_tag :div, id: 'code' do
      style = content_tag :style do
        `curl http://codepen.io/jmuheim/pen/#{pen_id}.css`.html_safe
      end

      example = `curl http://codepen.io/jmuheim/pen/#{pen_id}.html`.html_safe

      example += content_tag :div, id: 'codepen' do
        content_tag :p do
          "Play around<br>with this code on<br>#{link_to 'Codepen.io', "http://codepen.io/jmuheim/pen/#{pen_id}"}!".html_safe
        end
      end

      style + example
    end
  end
end
