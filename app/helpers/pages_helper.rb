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
            if item[:channel_image_url].present?
            concat(content_tag(:div, class: "source-and-headline-container") do
                concat(image_tag(item[:channel_image_url].strip, class: "source-icon"))
                concat(content_tag(:h3, class: "headline") do
                link_to(item[:link]) do
                    item[:title]
                end
                end)
            end)
            end
            concat(content_tag(:div, class: "article-image-container") do
            if item[:image_url].present?
                image_tag(item[:image_url].to_s, class: "resizable-image", onclick: "adjustImageSize(this, '100%')")
            end
            end)
        end
    end      
end

# HTML STRUCTURE HELPER FUNCTION CREATES:
# <ul class="articles-list">
#       <% @thehill_items.take(3).each do |item| %>
#         <% unless current_user.source_blocked?('thehill') %>
#           <li>
#             <div class="source-and-headline-container">
#               <% if item[:channel_image_url].present? %>
#                 <img class="source-icon" src="<%= item[:channel_image_url] %>">
#               <% end %>
#               <h3 class="headline">
#                 <a href="<%= item[:link] %>"><%= item[:title] %></a>
#               </h3>
#             </div>
#             <div class="article-image-container">
#               <img class="resizable-image" src="<%= item[:image_url] %>" onclick="adjustImageSize(this, '100%')">
#             </div>
#           </li>
#         <% end %>
#       <% end %>
# </ul>
