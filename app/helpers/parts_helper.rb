module PartsHelper
	def shorten_description(description)
		data = description[0...40]
		open = data.count('<')
		closed = data.count('>')
		result =  data + '>'*(open-closed) + ' Read more...'
		result
	end
end
