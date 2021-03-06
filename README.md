# Party Planner Prototype - Flutter

## About the app and its functionality:

*Notes: 

- To test send email (add invitee to party), please use a physical device or install a mail app on your simulator
- In the beginning, after navigate from splash screen to home screen, under debug or terminal window, there is a logger from flutter. I used this to keep track of the local file destination (format: `/Devices/device-uuid/data/Containers/Data/Application/application-uuid/Documents/data'` on ios device)

### 1. Route mapping:

- Splash screen as initial startup route

```python
'splash_screen': (BuildContext context) => LandingScreen(),
'home_screen': (BuildContext context) => HomeScreen(),
'detail_screen': (BuildContext context) => PartyDetailScreem(),
'new_party': (BuildContext context) => PartyDetailScreem(),
```

### 2. Home screen:

route: `home_screen`

- Showing list of parties and their details:
    - Vertical scrolling, with event date as divider to present events in group
    - Each party is presented in a party_card (`lib/screens/home_screen/components/party_card.dart`). Detail of a party card includes the following details and components:
        - `PartyCardTopDetail` (randomized) party icon,  party_name, invitation_sent (as a checkmark when true and as a paper_send icon when false), number of people are invited (going)
        - `PartyCardBottomDetail`: 2 yellow cards, 1 display the start time of the party, one display location (using lat and long of the device current location)
    - On tap on each party card will direct user to route `detail_screen`
    - Add button (floating button) at the bottom of the screen: To add new party (then redirect to `new_party` route)

### 3. Detail screen:

route: `detail_screen`

- Display the detail of each party
- The detail screen consists of followings details and components:
    - `PartyHeroImage` component in the top of the screen: loaded by `party.imageLink` property (network image, meaning the hero image component used url instead of locally stored image) (`lib/screens/detail_screen/components/hero_image.dart`)
    - `PartyDetailView` component, wrapped inside a Container with 1 border clipped (`lib/screens/detail_screen/components/party_detail_view.dart`)
        - Party title and invitation_sent at the top
        - Party location
        - `PartyDetailTimeCard` to display time and date of the party (`lib/screens/detail_screen/components/party_time_card.dart`)
            - On tap on the calendar icon will prompt a `bottomsheet` which let you to choose to add this event to phone calendar. Please for testing sake choose the first option `Calendar`
            - A modal will appear letting you know whether the event is added or not (prevent duplication)
            - On android device, this process is explicit. you will be directed to your phone calendar app in between steps. On ios device this process happens in the background. To test, please open your device calendar app and check.
        - Party description
        - List of invitees (`InviteeListView` component): (`lib/screens/detail_screen/components/invitee_list_view.dart`)
        - Edit button: on tap will direct user to PartyEditView ( route `new_party`)

### 4. Edit screen:

route: `new_party`

- Vertical scrolling (**!important** as this usually seem not so obvious)
- Provide functionality to edit a party details and add/remove invitees
- The screen includes the following components and details:
    - Party name edit field (with `initial_value` is the current party name and `helptext`)
    - Party description edit field (with `initial_value` is the current party description and `helptext`)
    - Location edit field: on tap will display (prefill) with current location
    - Party time and date: prefill with party current time and date (on tap will trigger time and date picker)
    - `InviteeListView` with name of invitee and a trailing icon ( a `remove` icon, on tap will remove the invitee)
    - `new_invitee` section: on tap on the `add` icon will open phone contact list. Initially you will be prompted to give contacts access to the app. after that the contacts will be displayed in a `bottom_sheet` (`_openInviteBottomSheet`), with contact name and a trailing add icon. on tap on this add icon will add the invitee to the party and send invite email ( `mailto` )
- Bottom of the screen: `Save` and `Cancel` button. On tap `Save` will save the event to the list of parties in local file storage. On tap `Cancel` will remove (cancel) the event

### 5. Helper class:

- This class is genius!
- Include the following functions:
    - `modifyParty` update the party detail and save to local file
    - `addInviteeToParty` add new invitee to the party and save to local file
    - `deleteParty` (not implemented)
    - `removeInvitee` remove invitee and save to local file
    - `addParty` add new party and save to local file
    - `writeToFile` save record by writing them to local file
    - `sendEmail` send email on new invite or send update email
