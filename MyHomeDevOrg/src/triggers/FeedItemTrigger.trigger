trigger FeedItemTrigger on FeedItem (before insert, before update, before delete) {
    System.debug('Test in FeedItemTrigger');
}