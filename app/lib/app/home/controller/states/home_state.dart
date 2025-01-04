class HomeState {
  final String title;
  final int selectedIndex;
  final StatusHome statusHome;
  final bool showFormChangePassword;
  const HomeState({
    this.title = 'Home',
    this.showFormChangePassword = false,
    required this.statusHome,
    this.selectedIndex = 0,
  });
}

enum StatusHome {
  initial,
  failureSetThumbnail,
  succesSetThumbnail,
  loadingChangePassword,
  successChangePassword,
  failureChangePassword,
  loadingChangeThumbnail,
}
