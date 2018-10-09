deploy:
	s3put -b www.mndflmeditation.com --header "Content-Type=text/html" --header "X-Server-Mood=Skeptical" -p "`pwd`/build" build/*
	s3put -b www.mndflmeditation.com -p "`pwd`" assets/css/
deploy-assets:
	s3put -b www.mndflmeditation.com -p "`pwd`" assets/*
deploy-teachers:
	s3put -b www.mndflmeditation.com -p "`pwd`" assets/data/teacher.json
	aws cloudfront create-invalidation --distribution-id E3KEPB1VPDC9EN --paths /assets/data/teacher.json
clean:
	rm -fr build/
	find . -name '*~' -delete
port = 8808
open:
	open -a 'Google Chrome' "http://localhost:$(port)"
run:
	open -a 'Google Chrome' "http://localhost:$(port)"
	python -m SimpleHTTPServer $(port)
teachers:
	curl 'https://docs.google.com/spreadsheets/d/1DrVWUQ1RA2MmWtlO4CUUHd3OR5eGDwLvKL2he5XXxYY/export?format=csv&id=1DrVWUQ1RA2MmWtlO4CUUHd3OR5eGDwLvKL2he5XXxYY&gid=0' -H 'Upgrade-Insecure-Requests: 1' -H 'Referer: https://docs.google.com/spreadsheets/d/1DrVWUQ1RA2MmWtlO4CUUHd3OR5eGDwLvKL2he5XXxYY/edit' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36' --compressed | ./tools/csv_importer.py | re '\s$$' > assets/data/teacher.json
