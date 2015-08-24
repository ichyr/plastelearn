module ExportHelper

	# Method creates hierarchy of directories
	# 
	# path - desired path to be created
	# 
	def self.reporting(path)
		self.create_folder(path)
	end

	def self.create_folder(path)
		tmp = path.split("/")
		tmp2 = "/"
		tmp.each do |part|
			tmp2 += part + "/"
			self.mkdir(tmp2) if !self.exists?(tmp2)
		end
	end

	def self.mkdir(path)
		Dir.mkdir(path)
	end

	def self.exists?(path)
		Dir.exist?(path)
	end
end