module ActionView
  module Helpers
    module StyleHelper
      # Returns a CSS style tag with the +content+ inside. Example:
      #   style_tag "h1 { color: red; }"
      #
      # Returns:
      #   <style>
      #     h1 { color: red; }
      #   </style>
      #
      # +html_options+ may be a hash of attributes for the <tt>\<style></tt>
      # tag.
      #
      #   style_tag "h1 { color: red; }", media: "all and (max-width: 500px)"
      #
      # Returns:
      #   <style media="all and (max-width: 500px)">
      #     h1 { color: red; }
      #   </style>
      #
      # Instead of passing the content as an argument, you can also use a block
      # in which case, you pass your +html_options+ as the first parameter.
      #
      #   <%= javascript_tag media: "all and (max-width: 500px)" do -%>
      #     h1 { color: red; }
      #   <% end -%>
      #
      # If you have a content security policy enabled then you can add an automatic
      # nonce value by passing <tt>nonce: true</tt> as part of +html_options+. Example:
      #
      #   <%= style_tag nonce: true do -%>
      #     h1 { color: red; }
      #   <% end -%>
      def style_tag(content_or_options_with_block = nil, html_options = {}, &block)
        content =
          if block_given?
            html_options = content_or_options_with_block if content_or_options_with_block.is_a?(Hash)
            capture(&block)
          else
            content_or_options_with_block
          end
    
        if html_options[:nonce] == true
          html_options[:nonce] = content_security_policy_nonce
        end
    
        content_tag("style", content.html_safe, html_options)
      end
    end
  end
end
