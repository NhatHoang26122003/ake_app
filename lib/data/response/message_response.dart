class MessageResponse<T> {
  List<T>? chatMessages;
  int? totalItems;
  int? itemPerPage;
  int? totalPages;
  int? page;
  int? currentPage;
  // bool? hasPrevPage;
  // bool? hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  MessageResponse({
    this.chatMessages,
    this.totalItems,
    this.itemPerPage,
    this.totalPages,
    this.page,
    this.currentPage,
    // this.hasPrevPage,
    // this.hasNextPage,
    this.prevPage,
    this.nextPage,
  });

  MessageResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    chatMessages = json["chatMessages"] == null
        ? null
        : (json["chatMessages"] as List).map((e) => fromJsonT(e as Map<String, dynamic>)).toList();
    totalItems = json["totalItems"];
    itemPerPage = json["itemPerPage"];
    totalPages = json["totalPages"];
    page = json["page"];
    currentPage = json["currentPage"];
    // hasPrevPage = json["hasPrevPage"];
    // hasNextPage = json["hasNextPage"];
    prevPage = json["prevPage"];
    nextPage = json["nextPage"];
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (chatMessages != null) {
      data["chatMessages"] = chatMessages?.map((e) => toJsonT(e)).toList();
    }
    data["totalItems"] = totalItems;
    data["itemPerPage"] = itemPerPage;
    data["totalPages"] = totalPages;
    data["page"] = page;
    data["currentPage"] = currentPage;
    // data["hasPrevPage"] = hasPrevPage;
    // data["hasNextPage"] = hasNextPage;
    data["prevPage"] = prevPage;
    data["nextPage"] = nextPage;
    return data;
  }
}