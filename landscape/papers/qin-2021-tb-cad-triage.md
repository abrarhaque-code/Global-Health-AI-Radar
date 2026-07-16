---
pmid: "34446265"
doi: "10.1016/S2589-7500(21)00116-3"
title: "Tuberculosis detection from chest x-rays for triaging in a high tuberculosis-burden setting: an evaluation of five artificial intelligence algorithms"
authors: ["Zhi Zhen Qin", "Shahriar Ahmed", "Mohammad Shahnewaz Sarker", "Kishor Paul", "Ahammad Shafiq Sikder Adel", "Tasneem Naheyan", "Rachael Barrett", "Sayera Banu", "Jacob Creswell"]
author_affiliations: ["Stop TB Partnership (CHE)", "icddr,b (BGD)"]
publication_year: 2021
journal: "The Lancet Digital Health"
disease_areas: ["tuberculosis"]
ai_category: "health_data_diagnostics_genomics"
ai_modalities: ["computer_vision"]
themes: ["theme_1"]
study_type: "diagnostic_accuracy"
countries_of_data: ["BGD"]
last_updated: "2026-07-16"
sources:
  - id: pm-001
    type: pubmed
    pmid: "34446265"
signal_strength: "high"
linked_companies: []
---

## Summary

An independent head-to-head evaluation of five commercial AI algorithms (CAD4TB v7, InferRead DR v2, Lunit INSIGHT CXR v4.9.0, JF CXR-1 v2, and qXR v3) reading chest X-rays for tuberculosis triage, using chest X-rays from 23,954 individuals recruited at three TB screening centres in Dhaka, Bangladesh, between 2014 and 2016 [pm-001]. Every participant received a digital chest X-ray and an Xpert MTB/RIF test, which served as the reference standard, and each X-ray was read independently by three registered radiologists and all five algorithms. Critically, the dataset had not been used to train any of the algorithms, which removes the overfitting that inflates vendor-reported numbers [pm-001].

All five algorithms significantly outperformed the radiologists on area under the ROC curve, led by qXR (90.81%) and CAD4TB (90.34%) [pm-001]. Measured against the WHO target product profile for a triage test (at least 90% sensitivity and at least 70% specificity), only qXR (74.3% specificity) and CAD4TB (72.9% specificity) cleared both bars at 90% sensitivity [pm-001]. All five reduced the number of confirmatory Xpert tests required by roughly 50% while holding sensitivity above 90%, and all five performed worse in people over 60 and people with a history of tuberculosis [pm-001]. The study was funded by the Government of Canada [pm-001].

## Why it matters

This is the reference point the diagnostics theme uses to keep AI chest-X-ray claims honest. It establishes three facts that recur across the composite cards in this radar: independent evaluation on an untrained dataset is the credible bar, not vendor benchmarks; leading algorithms genuinely clear the WHO triage TPP while others do not, so "AI-read chest X-ray" is not one capability but a spread; and the operating value is a large reduction in expensive molecular tests per case found, which is the unit economics that make community screening affordable. The documented degradation in older patients and prior-TB cases is the kind of honest limitation a serious diagnostics assessment has to carry forward into any deployment plan.

## Linked entities

No committed company cards link to this paper. The anonymized composite `composite-tb-cxr` is built in part on the class of product this study evaluates; the paper is cited there for the domain-level accuracy and TPP claims, never for company-specific ones.
