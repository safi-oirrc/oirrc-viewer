import { utils } from '@ohif/ui-next';

import ToolbarLayoutSelectorWithServices from './Toolbar/ToolbarLayoutSelector';

// legacy
import { ProgressDropdownWithService } from './Components/ProgressDropdownWithService';

// new
import ToolButtonListWrapper from './Toolbar/ToolButtonListWrapper';
import ToolRowWrapper from './Toolbar/ToolRowWrapper';
import { ToolBoxButtonGroupWrapper, ToolBoxButtonWrapper } from './Toolbar/ToolBoxWrapper';
import { ToolButtonWrapper } from './Toolbar/ToolButtonWrapper';

export default function getToolbarModule({ commandsManager, servicesManager }: withAppTypes) {
  const { cineService, viewportGridService } = servicesManager.services;
  return [
    // new
    {
      name: 'ohif.toolButton',
      defaultComponent: ToolButtonWrapper,
    },
    {
      name: 'ohif.toolButtonList',
      defaultComponent: ToolButtonListWrapper,
    },
    {
      name: 'ohif.row',
      defaultComponent: ToolRowWrapper,
    },
    {
      name: 'ohif.toolBoxButtonGroup',
      defaultComponent: ToolBoxButtonGroupWrapper,
    },
    {
      name: 'ohif.toolBoxButton',
      defaultComponent: ToolBoxButtonWrapper,
    },
    // others
    {
      name: 'ohif.layoutSelector',
      defaultComponent: props =>
        ToolbarLayoutSelectorWithServices({ ...props, commandsManager, servicesManager }),
    },
    {
      name: 'ohif.progressDropdown',
      defaultComponent: ProgressDropdownWithService,
    },
    {
      name: 'evaluate.cine',
      evaluate: () => {
        const isToggled = cineService.getState().isCineEnabled;
        return {
          className: utils.getToggledClassName(isToggled),
        };
      },
    },
    {
      name: 'evaluate.multipleViewports',
      evaluate: () => {
        const state = viewportGridService.getState();
        const { viewports } = state;

        // Count viewports with display sets
        const activeViewportsCount = Array.from(viewports.values()).filter(
          vp => vp.displaySetInstanceUIDs && vp.displaySetInstanceUIDs.length > 0
        ).length;

        // Enable button only when there are 2 or more viewports
        return {
          disabled: activeViewportsCount < 2,
        };
      },
    },
  ];
}
