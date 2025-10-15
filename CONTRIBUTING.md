
# Contributing to Locker

Please review this guide before opening an issue or submitting a Pull Request.

---

## Getting the code locally

Clone your forked repositry and create an isolated virtual environemnt.

```bash
git clone <fork-url>
cd Locker
```

-----

## Branching & workflow

1.  **Fork** the repository.
2.  Create a descriptive branch from `main` for your work.

```bash
git checkout main
git pull origin main

# create a feature branch (use 'fix/' for bug fixes)
git checkout -b feat/<feature-name>
```

-----

## Submitting a Pull Request (PR)

1.  Push your branch to your fork:

```bash
git add .
git commit -m "feat: <Give a short description of the feature>"
git push -u origin feat/<feature-name>
```

2.  Open a **Pull Request** against the **`acmpesuecc:main`** branch. In your PR description, please include:

      * What you changed and the problem it solves.
      * Any setup or specific steps required to test the change.
      * Screenshots if the change involves the UI.

3.  Address review comments and push follow-up commits to the same branch.

-----

## Code Style and Tips

  * Keep functions small and focused on a single task.
  * Add or update **inline comments** and **docstrings** where the behavior isn't immediately obvious.
  * Prefer clear, descriptive variable and function names.
  * Since the project uses Tkinter, focus on keeping the UI structure clean and responsive.

-----

## PR Checklist

Before requesting review, please run through this checklist:

  - [ ] My code follows the existing repository style.
  - [ ] I have tested my changes locally.
  - [ ] I updated relevant documentation (if applicable).
  - [ ] My PR has a clear title and description.