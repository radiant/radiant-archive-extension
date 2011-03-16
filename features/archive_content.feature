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
      <p><a href="/archive/2000/01/01/article-1/">Article 1</a></p>
      <p><a href="/archive/2001/02/02/article-2/">Article 2</a></p>
      <p><a href="/archive/2002/03/03/article-3/">Article 3</a></p>
      <p><a href="/archive/2003/04/04/article-4/">Article 4</a></p>
      <p><a href="/archive/2004/05/05/article-5/">Article 5</a></p>
      <p>Thanks for reading!</p>
      """

