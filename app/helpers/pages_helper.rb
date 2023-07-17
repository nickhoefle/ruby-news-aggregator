# In your helper file (e.g., app/helpers/pages_helper.rb)
module PagesHelper
    def render_article_list(items, source)
        content_tag(:ul, class: "articles-list") do
        items.take(3).each do |item|
            unless current_user.source_blocked?(source)
            concat(render_article_item(item))
            end
        end
        end
    end

    def render_article_item(item)
        content_tag(:li) do
        concat(content_tag(:div, class: "source-and-headline-container") do
            concat(image_tag(item[:channel_image_url], class: "source-icon")) if item[:channel_image_url].present?
            concat(content_tag(:h3, class: "headline") do
            link_to(item[:link]) do
                item[:title]
            end
            end)
        end)
        concat(content_tag(:div, class: "article-image-container") do
            image_tag(item[:image_url].to_s, class: "resizable-image", onclick: "adjustImageSize(this, '100%')")
        end)
        end
    end
end
