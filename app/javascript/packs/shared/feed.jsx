import React from 'react';
import FeedItem from './feed-item';

const Feed = ({ feedItems, reloadFeedItems }) => {
  const hasFeed = feedItems.length > 0;
  return (
    <div>
      {
        hasFeed && (
          <ol className="microposts">
            {feedItems.map(item => <FeedItem item={item} reloadFeedItems={reloadFeedItems} />)}
          </ol>
        )
      }
    </div>
  );
};

export default Feed;
