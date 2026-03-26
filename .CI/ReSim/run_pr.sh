event_number=$1
master_hash=$2
pkg_name=$3

# Run Modelica in all tools
tools=$4

for tool in tools
do 
  uppertool=$tool | tr 'a-z' 'A-Z'
  docker run --rm --name $tool\_pr_compare_$event_number\_$pkg_name --volume shared_data:/shared_data  $tool\_image python /shared_data/run_scripts/$uppertool\_PR_compare.py $master_hash $event_number $pkg_name            
done

#docker run --rm --name dymola_pr_compare_$event_number\_$pkg_name --volume shared_data:/shared_data  dymola_image python /shared_data/run_scripts/Dymola_PR_compare.py $master_hash $event_number $pkg_name          
#docker run --rm --name om_pr_compare_$event_number\_$pkg_name     --volume shared_data:/shared_data      om_image python /shared_data/run_scripts/OM_PR_compare.py     $master_hash $event_number $pkg_name
#docker run --rm --name wsm_pr_compare_$event_number\_$pkg_name    --volume shared_data:/shared_data     wsm_image python /shared_data/run_scripts/WSM_PR_compare.py    $master_hash $event_number $pkg_name

# create an overview over all tools
docker run --name create_overview_$event_number\_$pkg_name --volume shared_data:/shared_data om_image python /shared_data/run_scripts/overview_report.py $event_number $pkg_name

# clear published directory (web server)
if [ -d "/var/www/html/prs/$event_number/$pkg_name" ]; then
  rm -rf "/var/www/html/prs/$event_number/$pkg_name"
fi
if [ ! -d "/var/www/html/prs/$event_number" ]; then
    mkdir /var/www/html/prs/$event_number
fi
mkdir /var/www/html/prs/$event_number/$pkg_name

# copy data to webserver directory
docker cp create_overview_$event_number\_$pkg_name:/shared_data/resim_output/PRs/PR_$event_number/$pkg_name/report  /var/www/html/prs/$event_number/$pkg_name
docker rm create_overview_$event_number\_$pkg_name
exit $(head -n 1 /var/www/html/prs/$event_number/$pkg_name/status.txt)  