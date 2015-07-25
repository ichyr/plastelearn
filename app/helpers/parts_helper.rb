module PartsHelper
	def shorten_description(description)
		data = description[0...40]
		open = data.count('<')
		closed = data.count('>')
		result =  data + '>'*(open-closed) + ' ' + I18n.t("helpers.course.read_more")
		result
	end
end
