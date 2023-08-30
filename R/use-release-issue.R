
#' @export

use_release_issue <- function(version = NULL) {
  tr <- usethis:::target_repo(github_get = FALSE)
  version <- version %||% usethis:::choose_version(
    "What should the release version be?",
    which = c("major", "minor", "patch")
  )
  on_cran <- !is.null(usethis:::cran_version())
  checklist <- usethis:::release_checklist(version, on_cran)
  gh <- usethis:::gh_tr(tr)
  issue <- gh::gh(
    "POST /repos/{owner}/{repo}/issues",
    title = glue::glue("Release {project_name()} {version}"),
    body = paste0(checklist, "\n", collapse = "")
  )
  Sys.sleep(1)
  usethis:::view_url(issue$html_url)
}
