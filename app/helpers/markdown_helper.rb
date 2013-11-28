module MarkdownHelper
  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      sha = Digest::SHA1.hexdigest(code)
      Rails.cache.fetch ["code", language, sha].join('-') do
        Pygments.highlight(code, lexer: language)
      end
    end
  end

  def md(text, allow_html=true)
    renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: allow_html)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    emojify Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def emojify(content)
    h(content).to_str.gsub(/:([a-z0-9\+\-_]+):/) do |match|
    if Emoji.names.include?($1)
      '<img alt="' + $1 + '" height="20" src="' + asset_path("emoji/#{$1}.png") + '" style="vertical-align:middle" width="20" />'
    else
      match
    end
    end.html_safe if content.present?
  end
end
