#!/bin/bash

ae_models=(Vanilla TopoRegEdgeSymmetric)
ae_models_cycles=(TopoRegEdgeSymmetric)
competitor_methods=(PCA TSNE Isomap UMAP)
output_pattern='experiments/hyperparameter_search/dimensionality_reduction/{dataset}/{model}.json'
output_pattern_cycle='experiments/hyperparameter_search/dimensionality_reduction/{dataset}/{model}-cycle.json'


python scripts/configs_from_product.py exp.hyperparameter_search \
  --name model \
  --set ${ae_models[*]} \
  --name dataset  \
  --set SCurve SwissRoll \
  --name dummy --set overrides.model__parameters__autoencoder_model=MLPAutoencoder \
  --output-pattern ${output_pattern}

python scripts/configs_from_product.py exp.hyperparameter_search \
  --name model \
  --set ${ae_models[*]} \
  --name dataset  \
  --set Spheres \
  --name dummy --set overrides.model__parameters__autoencoder_model=MLPAutoencoder_Spheres \
  --output-pattern ${output_pattern}

python scripts/configs_from_product.py exp.hyperparameter_search \
  --name model \
  --set ${ae_models_cycles[*]} \
  --name dataset --set SCurve SwissRoll \
  --name dummy --set overrides.model__parameters__autoencoder_model=MLPAutoencoder \
  --name dummy2 --set overrides.model__parameters__toposig_kwargs__use_cycles=True \
  --output-pattern ${output_pattern_cycle}

python scripts/configs_from_product.py exp.hyperparameter_search \
  --name model \
  --set ${ae_models_cycles[*]} \
  --name dataset --set Spheres \
  --name dummy --set overrides.model__parameters__autoencoder_model=MLPAutoencoder_Spheres \
  --name dummy2 --set overrides.model__parameters__toposig_kwargs__use_cycles=True \
  --output-pattern ${output_pattern_cycle}

# Competitor
python scripts/configs_from_product.py exp.hyperparameter_search \
  --name model \
  --set ${competitor_methods[*]} \
  --name dataset --set SCurve SwissRoll Spheres \
  --output-pattern ${output_pattern}