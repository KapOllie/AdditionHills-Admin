abstract class AdminMenuItemEvent {
  const AdminMenuItemEvent();
}

class NavigateToEvent extends AdminMenuItemEvent {
  final int selectedIndex;
  const NavigateToEvent(this.selectedIndex);
}
