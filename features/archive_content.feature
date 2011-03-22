Feature: Serving pages from front-end
  In order to view the website content properly
  a visitor
  wants to see archive enhancements
  
  Scenario: Archive page basic rendering
    Given I am logged in as "existing"
    When I edit the "archive" page
    And I fill in the "body" content with the text
      """
      <h1>Articles</h1>
      <r:children:each><p><r:link /></p>
      </r:children:each><p>Thanks for reading!</p>
      """
    And I press "Save Changes"
    And I visit the "archive" page
    Then the page should render
      """
      <h1>Articles</h1>
      <p><a href="/archive/2000/01/01/article-z/">Article Z</a></p>
      <p><a href="/archive/2000/01/02/early-post/">Early Post</a></p>
      <p><a href="/archive/2000/01/03/z-post/">Z Post</a></p>
      <p><a href="/archive/2000/01/04/a-post/">A Post</a></p>
      <p><a href="/archive/2001/02/02/article-y/">Article Y</a></p>
      <p><a href="/archive/2002/03/03/article-x/">Article X</a></p>
      <p><a href="/archive/2003/04/04/article-w/">Article W</a></p>
      <p><a href="/archive/2004/05/05/article-v/">Article V</a></p>
      <p>Thanks for reading!</p>
      """

  
  Scenario: Archive Monthly Index children rendering
    Given I am logged in as "existing"
    When I edit the "month_index" page
    And I fill in the "body" content with the text
      """
      <h1>This Month's Articles</h1>
      <r:archive:children:each><p><r:link /></p>
      </r:archive:children:each><p>Thanks for reading the Monthly Archive!</p>
      """
    And I press "Save Changes"
    And I visit "/archive/2000/01/"
    Then the page should render
      """
      <h1>This Month's Articles</h1>
      <p><a href="/archive/2000/01/01/article-z/">Article Z</a></p>
      <p><a href="/archive/2000/01/02/early-post/">Early Post</a></p>
      <p><a href="/archive/2000/01/03/z-post/">Z Post</a></p>
      <p><a href="/archive/2000/01/04/a-post/">A Post</a></p>
      <p>Thanks for reading the Monthly Archive!</p>
      """