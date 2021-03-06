Feature: Command Line Processing
  As a author of LaTeX document I want to check spelling

  Scenario: Help can be printed
    When I run bin/texqc with "--help"
    Then Exit code is zero
    And Stdout contains "--help"

  Scenario: Good LaTeX log output can be checked
    Given I have a "article.tex" file with content:
    """
    \documentclass{article}
    \begin{document}
    How are you, my dear friend?
    \end{document}
    """
    When I run bash with "pdflatex article.tex"
    Then I run bin/texqc with "article"
    Then Exit code is zero
    And Stdout contains "No LaTeX processing errors found"

  Scenario: Bad LaTeX log output checked
    Given I have a "article.tex" file with content:
    """
    \documentclass{article}
    \begin{document}
    HowareyouHowareyouHowareyouHowareyouHowareyouHowareyouHowareyouHowareyouHowareyouHowareyouHowareyouHowareyouHowareyou
    \end{document}
    """
    When I run bash with "pdflatex article.tex"
    Then I run bin/texqc with "article"
    Then Exit code is not zero
    And Stdout contains "1 LaTeX processing errors"
