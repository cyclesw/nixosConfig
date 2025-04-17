{
  lib,
  stdenv,
  fetchurl,
  unzip,
  elasticsearch,
}:

let
  esVersion = elasticsearch.version;

  esPlugin =
    a@{
      pluginName,
      installPhase ? ''
        mkdir -p $out/config
        mkdir -p $out/plugins
        ln -s ${elasticsearch}/lib ${elasticsearch}/modules $out
        ES_HOME=$out ${elasticsearch}/bin/elasticsearch-plugin install --batch -v file://$src
        rm $out/lib $out/modules
      '',
      ...
    }:
    stdenv.mkDerivation (
      a
      // {
        inherit installPhase;
        pname = "elasticsearch-${pluginName}";
        dontUnpack = true;
        # Work around the "unpacker appears to have produced no directories"
        # case that happens when the archive doesn't have a subdirectory.
        sourceRoot = ".";
        nativeBuildInputs = [ unzip ];
        meta = a.meta // {
          platforms = elasticsearch.meta.platforms;
          maintainers = (a.meta.maintainers or [ ]) ++ (with lib.maintainers; [ offline ]);
        };
      }
    );
in
{

  analysis-icu = esPlugin rec {
    name = "elasticsearch-analysis-icu-${version}";
    pluginName = "analysis-icu";
    version = esVersion;
    src = fetchurl {
      url = "https://artifacts.elastic.co/downloads/elasticsearch-plugins/${pluginName}/${pluginName}-${version}.zip";
      hash =
        if version == "7.17.27" then
          "sha256-HGHhcWj+6IWZ9kQCGJD7HmmvwqYV1zjN0tCsEpN4IAA="
        else
          throw "unsupported version ${version} for plugin ${pluginName}";
    };
    meta = {
      homepage = "https://github.com/elastic/elasticsearch/tree/master/plugins/analysis-icu";
      description = "ICU Analysis plugin integrates the Lucene ICU module into elasticsearch";
      license = lib.licenses.asl20;
    };
  };

  analysis-ik = esPlugin rec {
    name = "elasticsearch-analysis-ik-${version}";
    pluginName = "analysis-ik";
    version = esVersion;
    src = fetchurl {
      url = "https://get.infini.cloud/elasticsearch/${pluginName}/${version}";
      hash = "sha256-vGEB6kChzSru8qhNNd7DBdqtBk2iJ0gyo41KmFXkkwI=";
    };

    meta = {
      homepage = "https://github.com/infinilabs/analysis-ik/tree/master";
      description = "The IK Analysis plugin integrates Lucene IK analyzer";
      license = lib.licenses.asl20;
    };
  };
}
