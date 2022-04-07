package ca.jrvs.apps.twitter.service;

import ca.jrvs.apps.twitter.dao.CrdDao;
import ca.jrvs.apps.twitter.dao.helper.TweetUtil;
import ca.jrvs.apps.twitter.model.Tweet;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class TwitterServiceUnitTest {

    @Mock
    CrdDao mockDao;

    @InjectMocks
    TwitterService twitterService;

    @Test
    public void postTweet() {
        Tweet expected = new Tweet();
        expected.setText("mock test");
        when(mockDao.create(any())).thenReturn(expected);
        Tweet actual = twitterService.postTweet(TweetUtil.buildTweet("test", 50.0, 0.0));
        assertEquals("mock test", actual.getText());
    }

    @Test
    public void showTweet() {
        Tweet expected = new Tweet();
        expected.setText("mock test");
        String[] fields = {};
        when(mockDao.findById(any())).thenReturn(expected);
        Tweet actual = twitterService.showTweet("1234", fields);
        assertEquals("mock test", actual.getText());
    }

    @Test
    public void deleteTweets() {
        Tweet expected = new Tweet();
        expected.setText("mock test");
        String[] ids = {"1234"};
        when(mockDao.deleteById(any())).thenReturn(expected);
        List<Tweet> actual = twitterService.deleteTweets(ids);
        assertEquals("mock test", actual.get(0).getText());
    }

}