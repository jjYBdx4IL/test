#!/bin/bash

set -Eex
set -o pipefail

git clone https://Fpf6kXQg@bitbucket.org/CoherentLogic/coherent-logic-fred-client.git
git clone https://Fpf6kXQg@bitbucket.org/CoherentLogic/coherent-logic-foundation-data-model.git

sed -i coherent-logic-foundation-data-model/bom/pom.xml -e 's:>2.4.1<:>2.22.2<:g'
pushd coherent-logic-foundation-data-model
git diff
popd
mvn clean install -DskipTests -f coherent-logic-foundation-data-model
mvn clean install -DskipTests -f coherent-logic-fred-client
mvn install -f coherent-logic-foundation-data-model
mvn -o test -f coherent-logic-fred-client/fred-client-core-it \
    "-Dtest=com.coherentlogic.fred.client.core.builders.QueryBuilderTest#getAllSeries"


