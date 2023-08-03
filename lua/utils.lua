local utils = {}

function utils.get_git_root()
    local file = io.popen('git rev-parse --show-toplevel')
    if not file then
        vim.notify('Not a git repository', vim.log.levels.ERROR)
        return nil
    end
    local git_root = file:read('*all'):gsub('%s$', '')
    file:close()
    return git_root .. '/'
end

function utils.get_git_submodule_parent_root()
    local original_path = vim.fn.getcwd()
    local git_root = utils.get_git_root()
    if not git_root then
        return nil
    end
    vim.fn.chdir(git_root .. '..')
    git_root = utils.get_git_root()
    if not git_root then
        return nil
    end
    vim.fn.chdir(original_path)
    return git_root
end

function utils.copy_file(src, dest)
    local input_file = io.open(src, 'rb')       -- open source file in binary mode
    if input_file then
        local output_file = io.open(dest, 'wb') -- open destination file in binary mode
        if output_file then
            local data = input_file:read('*a')  -- read all content from source file
            output_file:write(data)             -- write content to destination file
            input_file:close()                  -- always close files when you're done
            output_file:close()                 -- always close files when you're done
        else
            vim.notify('Cannot open destination file: ' .. dest, vim.log.levels.ERROR)
        end
    else
        vim.notify('Cannot open source file: ' .. src, vim.log.levels.ERROR)
    end
end

return utils
