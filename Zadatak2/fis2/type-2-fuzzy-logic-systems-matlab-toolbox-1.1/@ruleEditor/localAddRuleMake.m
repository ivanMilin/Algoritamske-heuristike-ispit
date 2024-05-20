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
function obj = localAddRuleMake(obj,fis)
if isprop(fis, 'input')
    numInputs=length(fis.input);
else
    numInputs=0;
end
if isprop(fis, 'output')
    numOutputs=length(fis.output);
else
    numOutputs=0;
end

if isprop(fis, 'rule')
    numRules=length(fis.rule);
else
    numRules=0;
end

% Information for all objects
frmColor=192/255*[1 1 1];
btnColor=192/255*[1 1 1];
popupColor=192/255*[1 1 1];
editColor=255/255*[1 1 1];
axColor=128/255*[1 1 1];

border=.01;
spacing=.01;
figPos=get(0,'DefaultFigurePosition');
maxRight=1;
maxTop=1;
btnWid=.14;
btnHt=0.05;


bottom=border+4*spacing+btnHt;
top=bottom+btnHt;
bottom=top+3*spacing;
top=maxTop-border-spacing;
right=maxRight-border-spacing;
left=border+spacing;
frmBorder=spacing;

%------------------------------------
% The RULES edit window1
boxHeight=(top-bottom)*1/4;
boxDstn=(right-left)/5;
boxWidth=(right-left)/6;
boxShiftY=(bottom+top)/8;
for i=0:numInputs-1
    rulePos=[left+i*boxDstn bottom+boxShiftY boxWidth boxHeight];
    if numRules>0,
        labelStr=' ';
    else
        labelStr=' ';
        msgStr=['No rules for system "' fis.name '"'];
        helper.statmsg(gcf,msgStr);
    end
    name=['ruleinmake' num2str(i+1)];
    if isfield(fis.input(i+1), 'mf') & ~isempty(fis.input(i+1).mf)
        str=helper.getFis(fis, 'input', i+1, 'mflabels');
        str=strvcat(str, 'none');
    else
        str=[];
    end
    ruleHndl=uicontrol( ...
        'Style','popup', ...
        'Units','normal', ...
        'Position',rulePos, ...
        'BackgroundColor',editColor, ...
        'HorizontalAlignment','left', ...
        'Max',1, ...
        'String', str,...
        'Tag',name);
    textPos=rulePos+[0, boxHeight+spacing, 0, btnHt*2/3-boxHeight];
    name=['ruleinlabel' num2str(i+1)];
    
    textHndl=uicontrol( ...
        'Style','text', ...
        'Units','normal', ...
        'Position',textPos, ...
        'BackgroundColor',frmColor, ...
        'String', [fis.input(i+1).name ' is'],...
        'HorizontalAlignment','center', ...
        'Tag',name);
    
    textPos=rulePos+[0, boxHeight+spacing+btnHt*2/3, 0, btnHt*2/3-boxHeight];
    name=['ruleinkeyw' num2str(i+1)];
    if i==0
        strname='If';
    else
        strHndl=findobj(gcf, 'Tag', 'radio');
        
        if get(strHndl(1), 'Value')==1
            strname=get(strHndl(1), 'String');
        else
            strname=get(strHndl(2), 'String');
        end
    end
    textHndl=uicontrol( ...
        'Style','text', ...
        'Units','normal', ...
        'Position',textPos, ...
        'BackgroundColor',frmColor, ...
        'String', strname,...
        'HorizontalAlignment','left', ...
        'Tag',name);
    
    pos=rulePos+[0, -btnHt, 0, btnHt-boxHeight];
    helpHndl=uicontrol( ...
        'Style','checkbox', ...
        'Units','normal', ...
        'Position',pos, ...
        'BackgroundColor',btnColor, ...
        'String','not', ...
        'Visible','on', ...
        'Tag', ['ruleinradio' num2str(i+1)],...
        'Max', 1,...
        'Value', 0);
    
end
endedge=left+(numInputs+numOutputs)*boxDstn+boxWidth;
if endedge>maxRight-left
    %out of border
    left1=left+numInputs*boxDstn;
    for i=0:numOutputs-1
        rulePos=[left1+i*boxDstn bottom+boxShiftY boxWidth boxHeight];
        name=['ruleoutmake' num2str(i+1)];
        if isfield(fis.output(i+1), 'mf') & ~isempty(fis.output(i+1).mf)
            str=helper.getFis(fis, 'output', i+1, 'mflabels');
            str=strvcat(str, 'none');
        else
            str=[];
        end
        ruleHndl=uicontrol( ...
            'Style','listbox', ...
            'Units','normal', ...
            'Position',rulePos, ...
            'BackgroundColor',editColor, ...
            'HorizontalAlignment','left', ...
            'String', str,...
            'Max',1, ...
            'Tag',name);
        textPos=rulePos+[0, boxHeight+spacing, 0, btnHt*2/3-boxHeight];
        name=['ruleoutlabel' num2str(i+1)];
        
        textHndl=uicontrol( ...
            'Style','text', ...
            'Units','normal', ...
            'Position',textPos, ...
            'BackgroundColor',frmColor, ...
            'String', [fis.output(i+1).name ' is'],...
            'HorizontalAlignment','center', ...
            'Tag',name);
        
        textPos=rulePos+[0, boxHeight+spacing+btnHt*2/3, 0, btnHt*2/3-boxHeight];
        name=['ruleoutkeyw' num2str(i+1)];
        if i==0
            strname='Then';
        else
            strname='and';
            %             strHndl=findobj(gcf, 'Tag', 'radio');
            %             if get(strHndl(1), 'Value')==1
            %                 strname=get(strHndl(1), 'String');
            %             else
            %                 strname=get(strHndl(2), 'String');
            %             end
        end
        textHndl=uicontrol( ...
            'Style','text', ...
            'Units','normal', ...
            'Position',textPos, ...
            'BackgroundColor',frmColor, ...
            'String', strname,...
            'HorizontalAlignment','left', ...
            'Tag',name);
        
        
        pos=rulePos+[0, -btnHt, 0, btnHt-boxHeight];
        helpHndl=uicontrol( ...
            'Style','checkbox', ...
            'Units','normal', ...
            'Position',pos, ...
            'BackgroundColor',btnColor, ...
            'String','not', ...
            'Visble','off', ...
            'Tag', ['ruleoutradio' num2str(i+1)],...
            'Max', 1,...
            'Value', 0);
        
    end
else
    for i=1:numOutputs
        outIndex=numOutputs+1;
        rulePos=[maxRight-i*boxDstn bottom+boxShiftY boxWidth boxHeight];
        name=['ruleoutmake' num2str(outIndex-i)];
        if isfield(fis.output(outIndex-i), 'mf') & ~isempty(fis.output(outIndex-i).mf)
            str=helper.getFis(fis, 'output', outIndex-i, 'mflabels');
            str=strvcat(str, 'none');
        else
            str=[];
        end
        ruleHndl=uicontrol( ...
            'Style','popup', ...
            'Units','normal', ...
            'Position',rulePos, ...
            'BackgroundColor',editColor, ...
            'HorizontalAlignment','left', ...
            'String', str,...
            'Max',1, ...
            'Tag',name);
        textPos=rulePos+[0, boxHeight+spacing, 0, btnHt*2/3-boxHeight];
        name=['ruleoutlabel' num2str(outIndex-i)];
        
        textHndl=uicontrol( ...
            'Style','text', ...
            'Units','normal', ...
            'Position',textPos, ...
            'BackgroundColor',frmColor, ...
            'String', [fis.output(outIndex-i).name ' is'],...
            'HorizontalAlignment','center', ...
            'Tag',name);
        
        textPos=rulePos+[0, boxHeight+spacing+btnHt*2/3, 0, btnHt*2/3-boxHeight];
        name=['ruleoutkeyw' num2str(outIndex-i)];
        if numOutputs==i
            strname='Then';
        else
            strname='and';
            %             strHndl=findobj(gcf, 'Tag', 'radio');
            %             if get(strHndl(1), 'Value')==1
            %                 strname=get(strHndl(1), 'String');
            %             else
            %                 strname=get(strHndl(2), 'String');
            %             end
        end
        textHndl=uicontrol( ...
            'Style','text', ...
            'Units','normal', ...
            'Position',textPos, ...
            'BackgroundColor',frmColor, ...
            'String', strname,...
            'HorizontalAlignment','left', ...
            'Tag',name);
        
        
        pos=rulePos+[0, -btnHt, 0, btnHt-boxHeight];
        helpHndl=uicontrol( ...
            'Style','checkbox', ...
            'Units','normal', ...
            'Position',pos, ...
            'BackgroundColor',btnColor, ...
            'String','not', ...
            'Visible','off',...
            'Tag', ['ruleoutradio' num2str(outIndex-i)],...
            'Max', 1,...
            'Value', 0);
        
    end
    
end