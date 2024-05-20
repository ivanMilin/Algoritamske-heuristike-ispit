%  IT2-FLS Toolbox is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     IT2-FLS Toolbox is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with IT2-FLS Toolbox.  If not, see <http://www.gnu.org/licenses/>.
function out=addVar_t2(it2fls,varType,varName,varRange,varargin)
out=it2fls;
numrules=length(it2fls.rule);
da = 0;  % A small increment to set mf parameter values

if strcmp(lower(varType),'input'),
    % Check that the input field exists
    if isprop(it2fls,'input') || isfield(it2fls,'input')
        index = length(it2fls.input) + 1;
    else
        index = 1;
    end
    
    if index == 1
        out.input = struct('name',[],...
            'range',[],...
            'mf',[]);
    else
        out.input(index) = struct('name',[],...
            'range',[],...
            'mf',[]);
    end
    
    out.input(index).name=varName;
    out.input(index).range=varRange;
    
    if nargin == 5 & isempty(out.input(index).mf)
        % Create default input membership functions
        out.input(index).mf = struct('name',cell(2,3),'type','trimf','params',[]);
        for id = 1:3
            out.input(index).mf(1,id).name   = sprintf('mf%iU',id);
            out.input(index).mf(1,id).params = [-1.8+da -1+da -0.2+da 1];
            da = da + 1;
        end
        %         % Create type2 membersihp functions
        da=0;
        for id = 1:3
            out.input(index).mf(2,id).name   = sprintf('mf%iL',id);
            out.input(index).mf(2,id).params = [-1.6+da -1+da -0.4+da 0.7];
            da = da + 1;
        end
        
        
    end
    
    % newly added: for sugeno type, the length of output linear MF params
    % should always be number of input plus 1
    if strcmpi(out.type,'sugeno') && isprop(out,'output')  && ~isempty(out.output)
        for ct=1:length(out.output.mf)
            if strcmpi(out.output.mf(ct).type,'linear')
                out.output.mf(ct).params = [out.output.mf(ct).params -1];
            end
        end
    end
    
    % Need to insert a new column into the current rules list
    if numrules
        % Don't bother if there aren't any rules
        for i=1:numrules
            out.rule(i).antecedent(index)=0;
        end
    end
    
elseif strcmp(lower(varType),'output'),
    % Check that the output field exists
    if isprop(it2fls,'output')
        index = length(it2fls.output)+1;
    else
        index = 1;
    end
    
    if index == 1
        out.output = struct('name',[],...
            'range',[],...
            'mf',[],...
            'crisp','crisp');
    else
        out.output(index) = struct('name',[],...
            'range',[],...
            'mf',[],...
            'crisp','crisp');
    end
    
    out.output(index).name=varName;
    out.output(index).range=varRange;
    
    if nargin == 5 & isempty(out.output(index).mf)
        if strcmp(it2fls.type,'mamdani')
            % Create default output membership functions
            out.output(index).mf = struct('name',cell(1,3),'type','trimf','params',[]);
            for id = 1:3
                out.output(index).mf(id).name   = sprintf('mf%i',id);
                out.output(index).mf(id).params = [-0.4+da 0.0+da 0.4+da];
                da = da + 0.5;
            end
        else % It must be a Sugeno type
            % Create default output membership functions
            out.output(index).mf = struct('name',cell(1,3),'type','constant','params',[]);
            for id = 1:3
                out.output(index).mf(id).name   = sprintf('mf%i',id);
                out.output(index).mf(id).params(1,1) = da;
                out.output(index).mf(id).params(2,1) = da;
                da = da + 0.5;
            end
        end
    end
    % Need to insert a new column into the current rules list
    if numrules
        % Don't bother if there aren't any rules
        for i=1:numrules
            out.rule(i).consequent(index)=0;
        end
    end
end