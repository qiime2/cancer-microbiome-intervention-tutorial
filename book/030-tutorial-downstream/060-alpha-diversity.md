# Alpha diversity visualizations

```{usage-scope}
---
name: tutorial
---
```

```{usage-selector}
---
default-interface: galaxy-usage
---
```

## Alpha group significance

First we'll look for general patterns, in particular we may be interested in
subject and disease state as an influence for alpha diversity.

To start with, we'll examine 'observed features'
```{usage}

use.action(
    use.UsageAction('diversity', 'alpha_group_significance'),
    use.UsageInputs(
        alpha_diversity=core_metrics_results.observed_features_vector,
        metadata=sample_metadata),
    use.UsageOutputNames(visualization='alpha_group_sig_obs_feats')
)
```

The first thing to notice is the high variability in individual alpha diversity
(`PatientID`). The centers and spreads of the individual distributions are
likely to obscure other effects, so we will want to keep this in mind.
Additionally, we have repeated measures of each individual, so we are almost
certainly violating independence assumptions when looking at other categories.
(Kruskal-Wallis is a non-parameteric test, but like most tests, still requires
independence.)

Keeping in mind that other categories are probably inconclusive,
we notice that there are (amusingly, and somewhat reasurringly) differences
in stool consistency (solid vs non-solid).

Because these data were derived from a study in which participants recieved
auto-fecal microbiota transplant, we may also be interested in if there was a
difference in richness between the control group and the auto-FMT goup.

Looking at ``autoFmtGroup`` we see that there is no apparent difference, but
we also know that we are violating independence with our repeated measures, and
all patients recieved a bone-marrow transplant which may be a stronger effect.
(The goal of the auto-FMT was to mitigate the impact of the marrow transplant.)

We will use a more advanced statistical model to interpret this question.


## Linear Mixed Effects

In order to manage the repeated measures, we will use a linear
mixed-effects model. In a mixed-effects model, we combine fixed-effects (your
typical linear regression coefficients) with random-effects. These random
effects are some (ostensibly random) per-group coefficient which minimizes the
error within that group. In our situation, we would want our random effect to
be the `PatientID` as we can see each subject has a different baseline for
diversity (and we have multiple measures for each patient).
By making that a random effect, we can more accurately ascribe associations to
the fixed effects as we treat each sample as a "draw" from a per-group
distribution.

There are several ways to create a linear model with random effects, but we
will be using a *random-intercept*, which allows for the per-subject intercept
to take on a different average from the population intercept (modeling what we
saw in the group-significance plot above).

````{margin}
```{note}
It is called a random effect because the cause of the per-subject deviation
from the population intercept is not known. It's source is "random" in the
statistical sense. That is randomness is not introduced to the model, but is
instead tolerated by it. Additionally, unlike fixed-effects, there is no
particular meaning in the random-effect's estimate (and are therefore not
reported). After all, how would we ascribe any particular association to the
unknown?
```
````

First let's evaluate the general trend of the transplant.

```{usage}

md_observed_features = use.view_as_metadata(
    'md_observed_features',
     core_metrics_results.observed_features_vector)

merged_features = use.merge_metadata(
    'merged_features',
    sample_metadata,
    md_observed_features)

use.action(
    use.UsageAction('longitudinal', 'linear_mixed_effects'),
    use.UsageInputs(metadata=merged_features,
                    state_column='DayRelativeToNearestHCT',
                    individual_id_column='PatientID',
                    metric='observed_features'),
    use.UsageOutputNames(visualization='lme-obs-features-HCT')
)

```

Here we see a significant association between richness and to the bone marrow
transplant.

We may also be interested in the effect of the auto fecal microbiota
transplant. It should be known that these are generally correlated, so choosing
one model over the other will require external knowledge.


```{usage}
use.action(
    use.UsageAction('longitudinal', 'linear_mixed_effects'),
    use.UsageInputs(metadata=merged_features,
                    state_column='day-relative-to-fmt',
                    individual_id_column='PatientID',
                    metric='observed_features'),
    use.UsageOutputNames(visualization='lme-obs-features-FMT')
)
```

We also see a downward trend from the FMT. Since the goal of the FMT was to
ameliorate the impact of the bone marrow transplant, and the timing of the FMT
is related to the timing of the marrow transplant, we might deduce that the
negative coefficient is primarily related to the bone marrow transplant and is
simply echoed in this correlated measure (we can't prove this with statistics
alone however, instead we are using abductive reasoning).

Looking at the log-likelihood, we also note that the HCT result is slightly
better than the FMT in accounting for the loss of diversity. But only slightly,
if we were to perform model testing it may not prove significant.

In any case, we can ask a more targeted question to identify if the FMT was
useful in recovering diversity.

By adding the ``autoFmtGroup`` to our linear model, we can see if the there is
are different slopes for the two groups, based on an *interaction term*.


```{usage}
use.action(
    use.UsageAction('longitudinal', 'linear_mixed_effects'),
    use.UsageInputs(metadata=merged_features,
                    state_column='DayRelativeToNearestHCT',
                    group_columns='autoFmtGroup',
                    individual_id_column='PatientID',
                    metric='observed_features'),
    use.UsageOutputNames(visualization='lme-obs-features-treatmentVScontrol')
)
```

Here we see that the ``autoFmtGroup`` is not on its own a significant predictor
of richness, but its interaction term with ``DayRelativeToNearestHCT`` is.
This implies that there are different slopes between these groups, and we note
that given the coding of ``DayRelativeToNearestHCT:autoFmtGroup[T.treatment]``
we have a positive coefficient which counteracts (to a degree) the negative
coefficient of ``DayRelativeToNearestHCT``.

```{warning}
The slopes of the regression scatterplot are not the same fit as our
mixed-effects model here. They are a naive OLS fit to give a sense of the
situation. A proper visualization would be a partial regression plot which can
condition on other terms to show some effect in "isolation". This is not
currently implemented in QIIME 2.
```

**How would you test the above models with a different diversity index, such as
Faith's Phylogenetic Diversity?**
