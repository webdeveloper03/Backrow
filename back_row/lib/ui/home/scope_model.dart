class ScopeModel{
  String scopeOverollTitle;
  String count;
  List<ItemsViewList> itemsList;
  ScopeModel({this.scopeOverollTitle,this.itemsList,this.count});

}

class ItemsViewList{
  String scopeTitleOrDateString;
  String date;
  String description;
  String status;
  String highLight;
  String fileLink;
    String scopeCount;
    String availableCount;
  FirstViewItem firstViewItem;
  String itemTitle;
  String location;
  List<SubItemsViewList> subItemList;
  String onsite;
  ItemsViewList({this.highLight,this.location,this.description,this.onsite,this.scopeTitleOrDateString,this.scopeCount,this.firstViewItem,this.subItemList,this.itemTitle,this.date,this.fileLink,this.status,this.availableCount});

}

class FirstViewItem{
  String itemTitle;
  String itemImageIcon;
  String itemSubTitle;
  String description;
  String subItemCountOrDateString;
  FirstViewItem({this.itemTitle,this.itemImageIcon,this.itemSubTitle,this.description,this.subItemCountOrDateString});

}

class SubItemsViewList{
  String itemTitle;
  String itemImageIcon;
  String description;
  String subItemCountOrDateTimeString;
  bool isViewBtnEnable;
  SubItemsViewList({this.itemTitle,this.itemImageIcon,this.subItemCountOrDateTimeString,this.description,this.isViewBtnEnable});

}