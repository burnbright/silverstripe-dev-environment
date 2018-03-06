<?php

# Render a list of links to sub-folders
$dirs = array_filter(glob('*'), 'is_dir');
foreach ($dirs as $dir) {
    echo "<a href='$dir'>$dir</a> <br>";
}
