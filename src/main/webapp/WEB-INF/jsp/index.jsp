<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id"
      content="830311996196-jc7lgtdthh22knv6p40sjg0nnn0ln374.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


<script>

    function onSignIn(googleUser) {
        // Useful data for your client-side scripts:
        var profile = googleUser.getBasicProfile();
        console.log("ID: " + profile.getId()); // Don't send this directly to your server!
        console.log('Full Name: ' + profile.getName());
        console.log('Given Name: ' + profile.getGivenName());
        console.log('Family Name: ' + profile.getFamilyName());
        console.log("Image URL: " + profile.getImageUrl());
        console.log("Email: " + profile.getEmail());

        // The ID token you need to pass to your backend:
        var id_token = googleUser.getAuthResponse().id_token;
        console.log("ID Token: " + id_token);
    };


    // 2. This code loads the IFrame Player API code asynchronously.
    var tag = document.createElement('script');

    tag.src = "https://www.youtube.com/iframe_api";
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    // 3. This function creates an <iframe> (and YouTube player)
    //    after the API code downloads.
    var player;
    function onYouTubeIframeAPIReady() {
        player = new YT.Player('player', {
            height: '390',
            width: '640',
            videoId: '${videoId}',
            events: {
                'onReady': onPlayerReady,
                'onStateChange': onPlayerStateChange
            }
        });


        console.log(test);
    }

    // 4. The API will call this function when the video player is ready.
    function onPlayerReady(event) {
        event.target.playVideo();
    }

    // 5. The API calls this function when the player's state changes.
    //    The function indicates that when playing a video (state=1),
    //    the player should play for six seconds and then stop.
    var done = false;
    function onPlayerStateChange(event) {
        if (event.data == YT.PlayerState.PLAYING && !done) {
            setTimeout(stopVideo, 6000);
            done = true;
        }
    }

    function stopVideo() {
        player.stopVideo();
    }
</script>

<section>
    <html>
    <div>
        <div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div>
    </div>
    <div>
        <input placeholder="Enter Video Id" type="text" id="videoId"/>
        <button type="button" class="btn small-btn" onclick="location.href = '?videoId=' + videoId.value">Retrieve </button>
        <div id="player"></div>
        <table>
            <thread>
                <tr style="cursor: pointer;">
                    <th>Name</th>
                    <th>Message</th>
                </tr>
            </thread>
            <c:forEach items="${liveMessages}" var="liveMessage">
                <tr>
                    <td>${liveMessage.authorDetails.displayName}</td>
                    <td>${liveMessage.snippet.displayMessage}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
    </html>
</section>
