#!/usr/bin/env python3

"""
Generate NIH Grant Workflow Diagram

Creates a visual flowchart showing the progression from template to submission-ready document.
"""

import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch
import numpy as np


def create_workflow_diagram():
    """Create and save the NIH grant workflow diagram"""

    fig, ax = plt.subplots(1, 1, figsize=(14, 18))
    ax.set_xlim(0, 10)
    ax.set_ylim(0, 20)
    ax.axis("off")

    # Color scheme
    colors = {
        "start": "#e1f5fe",  # Light blue
        "process": "#fff3e0",  # Light orange
        "decision": "#fce4ec",  # Light pink
        "success": "#c8e6c9",  # Light green
        "revision": "#ffecb3",  # Light yellow
    }

    # Helper function to create boxes
    def create_box(x, y, width, height, text, color, text_size=10):
        box = FancyBboxPatch(
            (x - width / 2, y - height / 2),
            width,
            height,
            boxstyle="round,pad=0.1",
            facecolor=color,
            edgecolor="black",
            linewidth=1.5,
        )
        ax.add_patch(box)
        ax.text(
            x,
            y,
            text,
            ha="center",
            va="center",
            fontsize=text_size,
            fontweight="bold",
            wrap=True,
        )

    # Helper function to create diamond (decision)
    def create_diamond(x, y, width, height, text, color, text_size=9):
        diamond = patches.RegularPolygon(
            (x, y),
            4,
            radius=width / 2,
            orientation=np.pi / 4,
            facecolor=color,
            edgecolor="black",
            linewidth=1.5,
        )
        ax.add_patch(diamond)
        ax.text(
            x, y, text, ha="center", va="center", fontsize=text_size, fontweight="bold"
        )

    # Helper function to draw arrows
    def draw_arrow(x1, y1, x2, y2, text=""):
        ax.annotate(
            "",
            xy=(x2, y2),
            xytext=(x1, y1),
            arrowprops=dict(arrowstyle="->", lw=2, color="black"),
        )
        if text:
            mid_x, mid_y = (x1 + x2) / 2, (y1 + y2) / 2
            ax.text(
                mid_x + 0.3,
                mid_y,
                text,
                fontsize=8,
                bbox=dict(boxstyle="round,pad=0.3", facecolor="white", alpha=0.8),
            )

    # Title
    ax.text(
        5,
        19.5,
        "NIH Grant Workflow: Template to Submission",
        ha="center",
        va="center",
        fontsize=18,
        fontweight="bold",
    )

    # Start
    create_box(5, 18.5, 2.5, 0.6, "Start: Need NIH Grant", colors["start"])

    # Quick start
    create_box(5, 17.5, 2.5, 0.6, "Run quick_start.py", colors["process"])
    draw_arrow(5, 18.2, 5, 17.8)

    # Grant type selection
    create_diamond(5, 16.3, 1.8, 1.8, "Select\nGrant Type", colors["decision"])
    draw_arrow(5, 17.2, 5, 17)

    # Grant types
    create_box(2, 15, 1.8, 0.8, "R01\nMajor Research\n12 pages", colors["process"], 8)
    create_box(5, 15, 1.8, 0.8, "R03\nSmall Grant\n6 pages", colors["process"], 8)
    create_box(8, 15, 1.8, 0.8, "R21\nExploratory\n6 pages", colors["process"], 8)

    draw_arrow(4.2, 15.8, 2.8, 15.4)
    draw_arrow(5, 15.8, 5, 15.4)
    draw_arrow(5.8, 15.8, 7.2, 15.4)

    # Project details
    create_box(5, 13.8, 2.5, 0.6, "Enter Project Details", colors["process"])
    draw_arrow(2, 14.6, 4, 14.1)
    draw_arrow(5, 14.6, 5, 14.1)
    draw_arrow(8, 14.6, 6, 14.1)

    # Template copied
    create_box(
        5,
        12.8,
        3,
        0.6,
        "Template Copied to\nmy_grants/project_name/",
        colors["process"],
    )
    draw_arrow(5, 13.5, 5, 13.1)

    # Edit documents
    create_box(5, 11.8, 2.5, 0.6, "Edit Core Documents", colors["process"])
    draw_arrow(5, 12.5, 5, 12.1)

    # Document types
    create_box(1.5, 10.5, 1.8, 0.6, "Specific Aims\n1 page", colors["process"], 9)
    create_box(
        3.5, 10.5, 1.8, 0.6, "Research Strategy\n6-12 pages", colors["process"], 9
    )
    create_box(6.5, 10.5, 1.8, 0.6, "Biosketch\n5 pages/person", colors["process"], 9)
    create_box(8.5, 10.5, 1.8, 0.6, "Budget &\nJustification", colors["process"], 9)

    draw_arrow(4.2, 11.5, 1.5, 10.8)
    draw_arrow(4.5, 11.5, 3.5, 10.8)
    draw_arrow(5.5, 11.5, 6.5, 10.8)
    draw_arrow(5.8, 11.5, 8.5, 10.8)

    # Content review
    create_diamond(5, 9, 1.8, 1.8, "Content\nReview", colors["decision"])
    draw_arrow(1.5, 10.2, 4.2, 9.5)
    draw_arrow(3.5, 10.2, 4.5, 9.5)
    draw_arrow(6.5, 10.2, 5.5, 9.5)
    draw_arrow(8.5, 10.2, 5.8, 9.5)

    # Revision cycle
    create_box(8, 9, 1.8, 0.6, "Revise Content", colors["revision"])
    draw_arrow(5.8, 9, 7.2, 9, "Needs Work")
    draw_arrow(8, 9.3, 8, 11.2)
    draw_arrow(7.8, 11.5, 5.8, 11.5)

    # Compile
    create_box(5, 7.5, 2.5, 0.6, "Compile with Typst", colors["process"])
    draw_arrow(5, 8.2, 5, 7.8, "Ready")

    # Generate PDF
    create_box(5, 6.5, 2.5, 0.6, "Generate PDF", colors["process"])
    draw_arrow(5, 7.2, 5, 6.8)

    # Quality check
    create_diamond(5, 5.3, 1.8, 1.8, "Quality\nCheck", colors["decision"])
    draw_arrow(5, 6.2, 5, 6)

    # Format/content fixes
    create_box(2, 5.3, 1.8, 0.6, "Fix Formatting", colors["revision"])
    create_box(8, 5.3, 1.8, 0.6, "Edit Content", colors["revision"])

    draw_arrow(4.2, 5.3, 2.8, 5.3, "Format Issues")
    draw_arrow(5.8, 5.3, 7.2, 5.3, "Content Issues")
    draw_arrow(2, 5.6, 2, 7.2)
    draw_arrow(2.2, 7.5, 3.8, 7.5)
    draw_arrow(8, 5.6, 8, 11.2)

    # Internal review
    create_box(5, 3.8, 2.5, 0.6, "Internal Review", colors["process"])
    draw_arrow(5, 4.5, 5, 4.1, "Ready")

    # Feedback
    create_diamond(5, 2.6, 1.8, 1.8, "Feedback", colors["decision"])
    draw_arrow(5, 3.5, 5, 3.3)

    # Revision paths
    create_box(1.5, 2.6, 1.8, 0.6, "Substantial\nRevisions", colors["revision"])
    create_box(8.5, 2.6, 1.8, 0.6, "Polish &\nFinal Edits", colors["process"])

    draw_arrow(4.2, 2.6, 2.3, 2.6, "Major Changes")
    draw_arrow(5.8, 2.6, 7.7, 2.6, "Minor Changes")
    draw_arrow(1.5, 2.9, 1.5, 11.2)
    draw_arrow(1.7, 11.5, 3.8, 11.5)

    # Final compilation
    create_box(5, 1.3, 2.5, 0.6, "Final Compilation", colors["process"])
    draw_arrow(5, 1.9, 5, 1.6, "Approved")
    draw_arrow(8.5, 2.3, 6.2, 1.6)

    # Submission ready
    create_box(5, 0.5, 2.8, 0.6, "Submission-Ready PDF", colors["success"])
    draw_arrow(5, 1, 5, 0.8)

    # Add legend
    legend_x = 0.5
    legend_y = 1
    ax.text(legend_x, legend_y + 0.5, "Legend:", fontsize=12, fontweight="bold")

    legend_items = [
        ("Start/End", colors["start"]),
        ("Process", colors["process"]),
        ("Decision", colors["decision"]),
        ("Success", colors["success"]),
        ("Revision", colors["revision"]),
    ]

    for i, (label, color) in enumerate(legend_items):
        y_pos = legend_y - i * 0.3
        rect = patches.Rectangle(
            (legend_x, y_pos - 0.1), 0.3, 0.2, facecolor=color, edgecolor="black"
        )
        ax.add_patch(rect)
        ax.text(legend_x + 0.4, y_pos, label, fontsize=10, va="center")

    plt.tight_layout()
    plt.savefig("figures/nih_grant_workflow.png", dpi=300, bbox_inches="tight")
    plt.savefig("figures/nih_grant_workflow.pdf", bbox_inches="tight")

    print("Workflow diagrams saved as:")
    print("- figures/nih_grant_workflow.png")
    print("- figures/nih_grant_workflow.pdf")

    return fig


if __name__ == "__main__":
    create_workflow_diagram()
    plt.show()
