function stageData = addText(stageData, fieldname, text)

if isempty(stageData)
    stageData = struct( ...
                        fieldname, text ...
                        );
else
    stageData.(fieldname) = text;
end

end