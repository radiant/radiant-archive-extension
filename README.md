# Archive

[![Build Status](https://secure.travis-ci.org/radiant/radiant-archive-extension.png)](http://travis-ci.org/radiant/radiant-archive-extension)

The Archive extension extracts the Archive pages from their original place
in the Radiant distribution.

## Archive page

An archive page provides behavior similar to a blog archive or a news
archive. Child page URLs are altered to be in %Y/%m/%d format
(2004/05/06).

An archive page can be used in conjunction with the "Archive Year Index",
"Archive Month Index", and "Archive Day Index" page types to create year,
month, and day indexes.

## Archive Index pages

To create a year/month/day index for an archive, create a child page for the
archive and assign the "Archive [Year/Month/Day] Index" page type to it.

An index page makes following tags available to you:

    <r:archive:children>...</r:archive:children>

Grants access to a subset of the children of the archive page
that match the specific year/month/day which the index page is rendering.

The title and breadcrumb attributes of an index page are rendered using Ruby's
Time#strftime method.  Please refer to documentation for Time#strftime to
format these attributes.
