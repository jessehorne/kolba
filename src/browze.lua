local browze = {}

function browze.exists(path)
	local exists = io.open(path)

	return exists
end

function browze.get_all_files(path)
	local _files = {}

	function dig(path, files)
		for file in lfs.dir(path) do
			if file ~= "." and file ~= ".." then
				local f = path..'/'..file
				local attr = lfs.attributes(f)

				if attr.mode == "directory" then
					dig(f, files)
				else
					table.insert(_files, f)
				end
			end
		end
	end

	dig(path, _files)

	return _files
end

function browze.get_all_folders(path)
	local _folders = {}

	function dig(path, folders)
		for file in lfs.dir(path) do
			if file ~= "." and file ~= ".." then
				local f = path..'/'..file
				local attr = lfs.attributes(f)

				if attr.mode == "directory" then
					dig(f, folders)
					table.insert(_folders, f)
				end
			end
		end
	end

	dig(path, _folders)

	return _folders
end

return browze
