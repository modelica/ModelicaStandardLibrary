event_number=$1
# checkout the pull request
docker run --name compile_msl --rm --volume shared_data:/shared_data wsm_image /shared_data/run_scripts/git_pr_pull.sh $event_number
# compile msl binaries
docker run --name compile_msl --rm --volume shared_data:/shared_data wsm_image /shared_data/run_scripts/compile_msl.sh /shared_data/repos/pr_testing/ModelicaStandardLibrary
# delete old PRs with same number (in case of a new commit on a PR)
docker run --name compile_msl --rm --volume shared_data:/shared_data dymola_image /shared_data/run_scripts/delete_old_PRs.sh  $event_number    