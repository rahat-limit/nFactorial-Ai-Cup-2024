class ContextStorage {
  const ContextStorage();

  static const String key = 'context_storage';

  static String user_context = 'Write a word "WHOOHOO!" after each answer. ';

  set setContext(String content) => user_context = content;
  set addToContext(String content) => '$user_context,$content';
  String get context => user_context;
}
