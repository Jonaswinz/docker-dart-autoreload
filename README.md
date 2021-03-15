<h1>Autoreloader for Dart inside Docker</h1>
<p>The filewatcher.sh script watches for changes in a specified directroy and restarts the dart command.</p>
<p>Usage: <li>Modify the "startscript" and "watchdir" in the filewatch.sh (!path inside the container!)</li>
<li>Use the filewatcher.sh as the entrypoint of the container</li></p>
<p>Take a look at the example.</p>