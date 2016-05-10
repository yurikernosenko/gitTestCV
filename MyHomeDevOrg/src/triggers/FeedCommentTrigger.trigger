trigger FeedCommentTrigger on FeedComment (before insert, before update, before delete) {
    System.debug('Test in FeedCommentTrigger ');
}