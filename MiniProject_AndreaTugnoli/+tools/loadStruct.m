function varargout = loadStruct(varargin)
% loadStruct: reads the table of the input file and returns the struct of
% it.
%
%   SYNTAX:     [struct1, struct2, ...] = tools.loadStruct('file1.txt', 'file2.txt', ...)
%

    assert(ischar([varargin{:}]), 'experiment:loadStruct:varargin', ...
        'The input arguments to load the Struct have to be character arrays.');

    varargout = cell(1,nargin);
    for currentArgin = 1:nargin
        varargout{currentArgin} = table2struct(...
            readtable(varargin{currentArgin}, 'Format', 'auto') ...
            );
    end
end