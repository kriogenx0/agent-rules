## Design Principles

They apply to every page, feature and backlog task; a task isn't done until it meets them. If the app does not have a UI, these can be ignored.

1. **Responsive on all devices.** Consider phones, tablets and larger displays for every page. On a phone, layouts fit a 375px-wide screen without horizontal scrolling, touch targets are large enough to tap, and nothing depends on hover or a keyboard shortcut alone. Check every change at mobile width as well as desktop, and any backlog task that would be desktop-only should say how it works on mobile.
2. **Native controls look the same everywhere.** Where browsers render them differently, style them: dialog boxes, buttons, text fields, selects (dropdowns), checkboxes and radio buttons.
3. **Interactive things react to the cursor; nothing else does.** Anything clickable changes when the cursor is over it. Anything that isn't clickable doesn't change on hover.
4. **View hierarchy: Global, then App, then View.** Libraries and global styles are the base, app-wide changes sit on top, and each view overrides what it inherits (see Styles in [frontend.md](frontend.md)).
5. **Text never touches the edge of the viewport.** Text at the edge looks cut off; use margin or padding to keep it in.
6. **Animations last 150ms to 300ms.** Under 150ms is too quick to notice as an animation. Over 300ms starts to feel slow, and over 500ms is annoying to wait for, so never go past it.
7. **Hover and other state changes never change an element's hover or click mask**, since a mask that moves or resizes under the cursor makes clicking glitchy. The visible element may grow or shrink on hover (for example with a `transform: scale()`), as long as the area that responds to hover and clicks stays exactly the same; anything that would shift layout or resize that area is not allowed.
8. **UI text that no one would select isn't selectable**: buttons, dropdowns, icons.
9. **Views only show things of value.** For example, don't show pagination when there's only one page.
10. **No invisible masks or state changes.** The area where a control changes state (hover, click, mouse cursor) matches its visible boundary. For example, hovering or clicking anywhere inside a text field's border, including its padding, changes the text field's state.
11. **Show that something is happening.** When the user is waiting on something, give a subtle indication that it's in progress.
12. Common actions can use icons instead of text. Buttons with uncommon icons should have a tooltip to show the action or intent.
13. **Icons are clear, familiar and monochrome.** Use icons where they are clear and familiar, and prefer a familiar icon over text. Use monochromatic icons that can match the text color. Emojis are never used as UI icons.
