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
classdef mainEditor
    properties
    end
    
    methods
        function obj = mainEditor(fis)
            command = 'new';
            %% Create it2fls
            if nargin==0
                fis=it2flsSession;
                fis=helper.addVar_t2(fis,'input','input1',[-1 1],'init');
                fis=helper.addVar_t2(fis,'output','output1',[-1 1],'init');
            else
                fis=it2flsSession(fis);
            end
            helper.setAppdata(fis);
            hfuzzyt2 = findall(0,'type','figure','Tag','fuzzyt2');
            if ~isempty(hfuzzyt2) && isequal(command,'new')
                figure(hfuzzyt2)
                return
            end
            selectColor=[1 0.3 0.3];
            hFuzzy = figure('Color',[0.8 0.8 0.8], ...
                'MenuBar','none', ...
                'NumberTitle','off', ...
                'Tag','fuzzyt2', ...
                'ToolBar','none',...
                'Visible','on',...
                'CloseRequestFcn',{@helper.saveFile},...
                'Name','Main Editor');
            set(hFuzzy,'Units','Normalized','Position',[0.05, 0.1, 0.4, 0.65]);
            %          set(hFuzzy, 'WindowStyle', 'docked')
            %         setFigDockGroup(hFuzzy, 'Interval Type-2 Fuzzy Logic Systems Toolbox');
            %movegui(hFuzzy,'north');
            %% Add Menus to the UI
            
            
            %% Get figure position
            %         figpos =  get(hFuzzy,'Position');
            %         FigRight=figpos(3);
            %         FigTop=figpos(4);
            %         Space=6;
            %         Bottom=250;
            FigLeft = 0.02;
            FigLeft2 = 0.55;
            step = 0.06;
            LenghtH = 0.15;
            LenghtV = 0.03;
            top=0.46;
            
            %% Add axes frame
            
            %         axpos=[Space Bottom FigRight+Space FigTop-Bottom+2*Space];
            axpos=[0.01 0.55 0.98 0.4];
            axHndl=axes( ...
                'Box','on', ...
                'Units','pixels', ...
                'Units','Normalized',...
                'Position',axpos, ...
                'Tag','mainaxesmain', ...
                'Visible','off');
            
            %% Frames
            frmColor=192/255*[1 1 1];
            popupColor=192/255*[1 1 1];
            
            frmPos= [0.00 0.00 1 0.52];
            mainFrmHndl=uicontrol( ...
                'Style','frame', ...
                'Units','pixel', ...
                'Units','Normalized',...
                'Position',frmPos, ...
                'BackgroundColor',frmColor);
            
            frmPos= [0.01 0.145 0.49 0.36];
            leftFrmHndl=uicontrol( ...
                'Style','frame', ...
                'Units','pixel', ...
                'Units','Normalized',...
                'Position',frmPos, ...
                'BackgroundColor',frmColor);
            
            frmPos= [0.01 0.01 0.49 0.122];
            leftFrmHndl=uicontrol( ...
                'Style','frame', ...
                'Units','pixel', ...
                'Units','Normalized',...
                'Position',frmPos, ...
                'BackgroundColor',frmColor);
            
            frmPos= [0.51 0.265 0.48 0.24];
            rightFrmHndl=uicontrol( ...
                'Style','frame', ...
                'Units','pixel', ...
                'Units','Normalized',...
                'Position',frmPos, ...
                'BackgroundColor',frmColor);
            
            frmPos= [0.51 0.01 0.48 0.24];
            rightFrmHndl=uicontrol( ...
                'Style','frame', ...
                'Units','pixel', ...
                'Units','Normalized',...
                'Position',frmPos, ...
                'BackgroundColor',frmColor);
            
            labelStr='Current Variable';
            pos=[FigLeft2 top LenghtH LenghtV];
            uicontrol( ...
                'Units','pixel', ...
                'Style','text', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized',...
                'HorizontalAlignment','left', ...
                'Position',pos, ...
                'String',labelStr);
            
            labelStr='Name';
            pos=[FigLeft2 top-step LenghtH LenghtV];
            uicontrol( ...
                'Style','text', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized',...
                'HorizontalAlignment','left', ...
                'Position',pos, ...
                'String',labelStr);
            
            name='currvarname';
            pos=[FigLeft2+0.2 top-step LenghtH LenghtV+0.01];
            inputVarNameHndl=uicontrol( ...
                'Style','edit', ...
                'HorizontalAlignment','left', ...
                'Enable','off', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized',...
                'Tag',name, ...
                'Max',2,...
                'Position',pos, ...
                'Callback',@varName);
            
            
            labelStr='Type';
            pos=[FigLeft2 top-2*step LenghtH LenghtV];
            uicontrol( ...
                'Style','text', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized',...
                'HorizontalAlignment','left', ...
                'Position',pos, ...
                'String',labelStr);
            
            name='currvartype';
            pos=[FigLeft2+0.204 top-2*step LenghtH LenghtV];
            hndl=uicontrol( ...
                'Style','text', ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized', ...
                'Position',pos, ...
                'Tag',name);
            
            labelStr='Range';
            pos=[FigLeft2 top-3*step LenghtH LenghtV];
            uicontrol( ...
                'Units','pixel', ...
                'Style','text', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized',...
                'HorizontalAlignment','left', ...
                'Position',pos, ...
                'String',labelStr);
            
            name='currvarrange';
            pos=[FigLeft2+0.204 top-3*step LenghtH LenghtV];
            outputVarNameHndl=uicontrol( ...
                'Style','text', ...
                'HorizontalAlignment','left', ...
                'Units','Normalized',...
                'Position',pos, ...
                'BackgroundColor',frmColor, ...
                'Tag',name);
            
            
            %% sol taraf
            % AND Method
            labelStr='And method';
            pos=[FigLeft top LenghtH LenghtV];
            hndl=uicontrol( ...
                'Style','text', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized',...
                'HorizontalAlignment','left', ...
                'Position',pos, ...
                'String',labelStr);
            
            % AND Method pop-up
            labelStr=str2mat(' min',' prod',' Custom...');
            name='andMethod';
            callbackStr='';
            pos=[FigLeft+0.3 top LenghtH LenghtV];
            hndl=uicontrol( ...
                'Style','popupmenu', ...
                'BackgroundColor',popupColor, ...
                'HorizontalAlignment','left', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'Callback',callbackStr, ...
                'Tag',name, ...
                'String',labelStr);
            set(hndl,'Value',2);
            % OR Method
            labelStr='Or method';
            pos=[FigLeft top-step LenghtH LenghtV];
            hndl=uicontrol( ...
                'Style','text', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized',...
                'HorizontalAlignment','left', ...
                'Position',pos, ...
                'String',labelStr);
            
            % OR Method pop-up
            labelStr=str2mat(' max',' probor',' Custom...');
            name='orMethod';
            callbackStr='';
            pos=[FigLeft+0.3 top-step LenghtH LenghtV];
            hndl=uicontrol( ...
                'Style','popupmenu', ...
                'BackgroundColor',popupColor, ...
                'HorizontalAlignment','left', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'Callback',callbackStr, ...
                'Tag',name, ...
                'String',labelStr);
            set(hndl,'Value',2);
            % Implication
            labelStr='Implication';
            pos=[FigLeft top-2*step LenghtH LenghtV];
            hndl=uicontrol( ...
                'Style','text', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized',...
                'HorizontalAlignment','left', ...
                'Position',pos, ...
                'String',labelStr);
            
            % Implication pop-up
            labelStr=str2mat(' min',' prod',' Custom...');
            name='impMethod';
            callbackStr='';
            pos=[FigLeft+0.3 top-2*step LenghtH LenghtV];
            hndl=uicontrol( ...
                'Style','popupmenu', ...
                'BackgroundColor',popupColor, ...
                'HorizontalAlignment','left', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'Callback',callbackStr, ...
                'Tag',name, ...
                'String',labelStr);
            set(hndl,'Enable','off');
            
            % Aggretion
            labelStr='Aggregation';
            pos=[FigLeft top-3*step LenghtH LenghtV];
            hndl=uicontrol( ...
                'Style','text', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized',...
                'HorizontalAlignment','left', ...
                'Position',pos, ...
                'String',labelStr);
            
            % Aggretion pop-up
            labelStr=str2mat(' max',' sum',' probor',' Custom...');
            name='aggMethod';
            callbackStr='';
            pos=[FigLeft+0.3 top-3*step LenghtH LenghtV];
            hndl=uicontrol( ...
                'Style','popupmenu', ...
                'BackgroundColor',popupColor, ...
                'HorizontalAlignment','left', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'Callback',callbackStr, ...
                'Tag',name, ...
                'String',labelStr);
            set(hndl,'Enable','off');
            % Defuzzification
            labelStr='Defuzzification';
            pos=[FigLeft top-4*step LenghtH LenghtV];
            hndl=uicontrol( ...
                'Style','text', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized',...
                'HorizontalAlignment','left', ...
                'Position',pos, ...
                'String',labelStr,...
                'visible','off');
            
            % Defuzzification pop-up
            labelStr=str2mat(' wtaver',' wtsum');
            name='defuzzMethod';
            callbackStr='';
            pos=[FigLeft+0.3 top-4*step LenghtH LenghtV];
            hndl=uicontrol( ...
                'Style','popupmenu', ...
                'BackgroundColor',popupColor, ...
                'HorizontalAlignment','left', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'Callback',callbackStr, ...
                'Tag',name, ...
                'String',labelStr,...
                'visible','off');
            
            
            % Type Reduction
            labelStr='Type Reduction and Defuzzification';
            pos=[FigLeft top-4.5*step LenghtH*2 LenghtV*2];
            hndl=uicontrol( ...
                'Style','text', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized',...
                'HorizontalAlignment','left', ...
                'Position',pos, ...
                'String',labelStr);
            
            % Type Reduction pop-up
            labelStr=str2mat('KM','EKM','IASC','EIASC','EODS','WM','NT','BMM','custom');
            name='typeredMethod';
            pos=[FigLeft+0.3 top-4*step LenghtH LenghtV];
            hndl=uicontrol( ...
                'Style','popupmenu', ...
                'BackgroundColor',popupColor, ...
                'HorizontalAlignment','left', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'Callback',@config, ...
                'Tag',name, ...
                'String',labelStr);
            
            %% save and export
            
            % Save
            %         img= imread('icon_ok.png');
            hndl = uicontrol( ...
                'Style','pushbutton',...
                'Units','Normalized',...
                'Position',[0.6 0.1 0.1 0.06],...
                'Callback',{@helper.saveFile 'save'},...
                'string','Save');
            %         jh = findjobj(pbh);
            % jh.setVerticalAlignment( javax.swing.AbstractButton.BOTTOM );
            
            % Export to simulink
            hndl = uicontrol( ...
                'Style','pushbutton',...
                'Units','Normalized',...
                'Position',[0.75 0.1 0.2 0.06],...
                'Callback','helper.createSim',...
                'string','Export to Simulink');
            
            % Generate PLC Code
            hndl = uicontrol( ...
                'Style','pushbutton',...
                'Units','Normalized',...
                'Position',[0.65 0.06 0.2 0.06],...
                'Callback','',...
                'string','Generate PLC Code',...
                'visible','off');
            addMenus(obj);
            plotFis(obj);
        end
    end
    
end

function [ obj ] = config( ~,~,obj )
%CONF�G Summary of this function goes here
%   Detailed explanation goes here
figNumber=gcf;

fis=helper.getAppdata;

TRmethods = get(findobj('tag','typeredMethod'),'String');
TRmethodsval = get(findobj('tag','typeredMethod'),'Value');

newTRmethod = deblank(TRmethods(TRmethodsval,:));
if strcmp(newTRmethod,'BMM')
    prompt={'alpha','beta'};
    name='Enter alfa and beta';
    numlines=1;
    defaultanswer={'0.5','0.5'};
    answer=inputdlg(prompt,name,numlines,defaultanswer);
    drawnow;
    
    fis.typeRedMethod=[newTRmethod '(' answer{1} ',' answer{2} ')'];
elseif strcmp(newTRmethod,'custom')
    try
        h=warndlg('Your costom Type Reduction method function have.');
        waitfor(h);
        [loadfis,path]=uigetfile('*.m','Select your Type Reduction m function.');
        pathtocopy=which('evalt2.m');
        parts = strfind(pathtocopy, '\');
        pathtocopy=pathtocopy(1:parts(end));
        copyfile([path loadfis], pathtocopy, 'f');
        fis.typeRedMethod=loadfis(1:end-2);
        msgbox('Your custom function successfully loaded.','Custom TR Function');
    catch
        errordlg('Your custom function loaded.','Custom TR Function');
    end
else
    fis.typeRedMethod=newTRmethod;
end
helper.setAppdata(fis);


end

function [ obj ] = varName( ~,~,obj )
figNumber=gcf;
selectColor=[1 0.3 0.3];
fis=helper.getAppdata;
currVarAxes=findobj(figNumber,'Type','axes','XColor',selectColor);
varIndex=get(currVarAxes,'UserData');
tag=get(currVarAxes,'Tag');
if strcmp(tag(1:5),'input'),
    varType='input';
else
    varType='output';
end

varNameHndl=findobj(figNumber,'Type','uicontrol','Tag','currvarname');
newName=deblank(get(varNameHndl,'String'));
% Strip off the leading space
if iscell(newName)
    newNameStr='';
    for i=1:length(newName) 
        newNameStr= strcat(newNameStr,newName{i});
    end
    newName=newNameStr;
end
newName=fliplr(deblank(fliplr(newName)));
% Replace any remaining blanks with underscores
newName(find(newName==32))=setstr(95*ones(size(find(newName==32))));
set(varNameHndl,'String',['' newName]);
msgStr=['Renaming ' varType ' variable ' num2str(varIndex) ' to "' newName '"'];
helper.statmsg(figNumber,msgStr);

% Change the name of the label in the input-output diagram
txtHndl=get(currVarAxes,'XLabel');
set(txtHndl,'String',newName);

eval(['fis.' varType '(' num2str(varIndex) ').name=''' newName ''';']);             %%strcmp does not work for structures
helper.setAppdata(fis);


end