require "open-uri"
require 'rubygems'
require 'hpricot'

# This Class 
#
module Core
	class CommonUtil 
  		def CommonUtil.get_string_by_url url
			result = ""
			open(url) do |f|
				result += f.read
			end

			return result
		end

		def CommonUtil.get_pre_list html_val
			doc = Hpricot(html_val)
			pre_list = doc.search("pre").map do |pre|
				pre.inner_html
			end
			return pre_list

		end
	end
end