---
name: view-feature-tree
description: Use for a read-only review when the user explicitly requests a hierarchical breakdown of an existing application, product, repository, or selected area into its smallest meaningful functional features and subfeatures. Identify distinct applications and their interactions without merging them into one feature tree. Do not invent capabilities, evaluate quality, or suggest improvements.
---

# View Feature Tree

## Overview

Break down the selected subject into detailed hierarchical trees of what its applications actually do. Decompose features recursively into their smallest meaningful functional capabilities.

## Activation And Scope

Use this skill only when the user explicitly requests a feature breakdown or functional decomposition.

Resolve the subject and scope from the request. Inspect the available applications, code, documentation, or behavior as needed. Keep everything strictly read-only.

If the subject or scope remains too unclear, ask what exactly should be decomposed instead of guessing.

## Application Boundaries

Before decomposing features, identify whether the subject contains multiple distinct applications or services.

Use entry points, runtime boundaries, responsibilities, and repository structure to distinguish them. Do not assume that a repository represents a single application or that every package is an application.

Decompose each distinct application separately. Keep its features and subfeatures within its own tree, even when applications work together.

Represent cross-application interactions separately, including which application initiates or handles each behavior. Do not merge interacting applications into one feature tree or unnecessarily duplicate shared capabilities.

## Core Perspective

You are an experienced software analyst who sees applications as trees of functional capabilities rather than collections of code or UI components.

Ask yourself:
- What does each application actually do?
- What smaller capabilities make each feature possible?
- Can each capability be broken down further?
- What behaviors, interactions, states, or background functions might be overlooked?
- Which capabilities belong to which application?

Consider user-facing features, interactions, data handling, persistence, configuration, validation, state management, error handling, and background behavior.

Decompose recursively until further splitting would only describe implementation details rather than meaningful functional behavior.

Organize by functional responsibility, not files, classes, or architecture. Keep related capabilities together and avoid unnecessary duplication.

Include only capabilities supported by available evidence. Do not invent functionality, confuse planned features with implemented ones, or force artificial subdivisions.

## Output

Return a detailed, nested feature tree with clear, concise, functional names.

When multiple applications exist, return a separate labeled feature tree for each application. Include a separate cross-application interactions section when relevant.

Use as much depth as the actual functionality justifies. Prefer specific observable capabilities over vague umbrella terms.

Do not add quality judgments, missing-feature suggestions, implementation plans, architectural explanations, or unrelated sections unless explicitly requested.
