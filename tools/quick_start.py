#!/usr/bin/env python3

"""
Interactive NIH Grant Creator

A user-friendly tool to create new grant applications from templates.
"""

import os
import sys
import shutil
from pathlib import Path
from datetime import datetime
import questionary
from rich.console import Console
from rich.panel import Panel
from rich.table import Table

console = Console()


class GrantCreator:
    """Interactive grant creation tool"""

    def __init__(self):
        self.root_dir = Path(__file__).parent.parent
        self.templates_dir = self.root_dir / "templates"
        self.grants_dir = self.root_dir / "my_grants"

    def run(self):
        """Main interactive flow"""
        console.clear()
        console.print(
            Panel.fit(
                "[bold cyan]NIH Grant Template Creator[/bold cyan]\n"
                "Create a new grant application from templates",
                border_style="cyan",
            )
        )

        # Get grant type
        grant_type = self._select_grant_type()
        if not grant_type:
            return

        # Get project details
        project_info = self._get_project_info()
        if not project_info:
            return

        # Create grant
        grant_dir = self._create_grant(grant_type, project_info)

        # Show next steps
        self._show_next_steps(grant_dir, grant_type)

    def _select_grant_type(self):
        """Select grant type from available templates"""
        templates = [d.name for d in self.templates_dir.iterdir() if d.is_dir()]

        if not templates:
            console.print("[red]No templates found![/red]")
            return None

        # Create table of options
        table = Table(title="Available Grant Types")
        table.add_column("Type", style="cyan")
        table.add_column("Description")
        table.add_column("Research Strategy")

        descriptions = {
            "R01": ("Major research project", "12 pages"),
            "R03": ("Small grant program", "6 pages"),
            "R21": ("Exploratory/Developmental", "6 pages"),
        }

        for template in templates:
            desc, pages = descriptions.get(template, ("Custom template", "Varies"))
            table.add_row(template, desc, pages)

        console.print(table)
        console.print()

        return questionary.select(
            "Select grant type:", choices=templates + ["Cancel"]
        ).ask()

    def _get_project_info(self):
        """Collect project information"""
        console.print("\n[bold]Project Information[/bold]")

        info = {}

        info["title"] = questionary.text(
            "Project title:", validate=lambda x: len(x) > 0
        ).ask()

        if not info["title"]:
            return None

        info["pi_name"] = questionary.text(
            "Principal Investigator name:", default="Dr. Jane Smith"
        ).ask()

        info["institution"] = questionary.text(
            "Institution:", default="University Medical Center"
        ).ask()

        info["project_name"] = questionary.text(
            "Project folder name:", default=info["title"].lower().replace(" ", "_")[:30]
        ).ask()

        return info

    def _create_grant(self, grant_type, project_info):
        """Create grant from template"""
        if grant_type == "Cancel":
            return None

        # Create project directory
        project_dir = self.grants_dir / project_info["project_name"]
        project_dir.mkdir(parents=True, exist_ok=True)

        # Copy template
        template_dir = self.templates_dir / grant_type

        console.print(f"\nCreating {grant_type} grant in {project_dir}...")

        # Copy files
        for item in template_dir.rglob("*"):
            if item.is_file():
                relative_path = item.relative_to(template_dir)
                target_path = project_dir / relative_path
                target_path.parent.mkdir(parents=True, exist_ok=True)

                # Process .typ files to replace placeholders
                if item.suffix == ".typ":
                    content = item.read_text()
                    content = content.replace("[Project Title]", project_info["title"])
                    content = content.replace("[PI Name]", project_info["pi_name"])
                    content = content.replace(
                        "[Institution]", project_info["institution"]
                    )
                    content = content.replace(
                        "Your Grant Title Here", project_info["title"]
                    )
                    content = content.replace("Dr. Jane Smith", project_info["pi_name"])
                    content = content.replace(
                        "University Medical Center", project_info["institution"]
                    )
                    target_path.write_text(content)
                else:
                    shutil.copy2(item, target_path)

        # Create README for the project
        readme_content = f"""# {project_info['title']}

**Grant Type**: {grant_type}
**PI**: {project_info['pi_name']}
**Institution**: {project_info['institution']}
**Created**: {datetime.now().strftime('%Y-%m-%d')}

## Files

- `{grant_type}.typ`: Main grant document
- `config.typ`: Configuration and formatting
- `references.bib`: Bibliography

## Compilation

```bash
typst compile --root {self.root_dir} {project_dir}/{grant_type}.typ
outputs/{project_info['project_name']}.pdf
```

## Notes
Add your project notes here...
"""
        (project_dir / "README.md").write_text(readme_content)

        console.print(f"[green]✓[/green] Grant created successfully!")
        return project_dir

    def _show_next_steps(self, grant_dir, grant_type):
        """Display next steps"""
        if not grant_dir:
            return

        console.print("\n[bold cyan]Next Steps:[/bold cyan]")
        console.print(
            f"1. Edit your grant: [yellow]code {grant_dir / f'{grant_type}.typ'}[/yellow]"
        )
        console.print(
            f"2. Compile: [yellow]typst compile --root . {grant_dir / f'{grant_type}.typ'} outputs/your_grant.pdf[/yellow]"
        )
        console.print(
            f"3. Check the README: [yellow]{grant_dir / 'README.md'}[/yellow]"
        )

        if questionary.confirm("\nWould you like to open the project in VSCode?").ask():
            os.system(f"code {grant_dir}")


def main():
    """Main entry point"""
    try:
        creator = GrantCreator()
        creator.run()
    except KeyboardInterrupt:
        console.print("\n[yellow]Cancelled by user[/yellow]")
        sys.exit(0)
    except Exception as e:
        console.print(f"\n[red]Error: {e}[/red]")
        sys.exit(1)


if __name__ == "__main__":
    main()
