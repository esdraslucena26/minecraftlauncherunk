import javax.swing.*;
import javax.swing.border.EmptyBorder;
import java.awt.*;
import java.io.File;

public class MinecraftLauncher extends JFrame {
    private static final String VERSION_TEXT = "Versão: 1.20.1";
    private static final String BACKGROUND_PATH = "assets/background.png";
    private static final String LOGO_PATH = "assets/logo.png";

    public MinecraftLauncher() {
        setTitle("Minecraft Launcher Simples");
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setSize(500, 700);
        setLocationRelativeTo(null);
        setResizable(false);

        BackgroundPanel content = new BackgroundPanel(BACKGROUND_PATH);
        content.setLayout(new BorderLayout());
        setContentPane(content);

        JPanel overlay = new JPanel();
        overlay.setOpaque(false);
        overlay.setLayout(new BoxLayout(overlay, BoxLayout.Y_AXIS));
        overlay.setBorder(new EmptyBorder(40, 30, 35, 30));

        JLabel logoLabel = createLogoLabel(LOGO_PATH);
        logoLabel.setAlignmentX(Component.CENTER_ALIGNMENT);

        JTextField usernameField = new JTextField();
        usernameField.setMaximumSize(new Dimension(Integer.MAX_VALUE, 44));
        usernameField.setPreferredSize(new Dimension(420, 44));
        usernameField.setFont(new Font("SansSerif", Font.PLAIN, 18));
        usernameField.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(new Color(30, 30, 30), 2),
                BorderFactory.createEmptyBorder(8, 10, 8, 10)
        ));
        usernameField.setToolTipText("Digite seu username");

        JButton playButton = new JButton("Jogar");
        playButton.setAlignmentX(Component.CENTER_ALIGNMENT);
        playButton.setFocusPainted(false);
        playButton.setBackground(new Color(79, 141, 66));
        playButton.setForeground(Color.WHITE);
        playButton.setFont(new Font("SansSerif", Font.BOLD, 20));
        playButton.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        playButton.setMaximumSize(new Dimension(Integer.MAX_VALUE, 50));

        JLabel versionLabel = new JLabel(VERSION_TEXT);
        versionLabel.setAlignmentX(Component.CENTER_ALIGNMENT);
        versionLabel.setForeground(Color.WHITE);
        versionLabel.setFont(new Font("SansSerif", Font.PLAIN, 14));

        playButton.addActionListener(e -> {
            String username = usernameField.getText().trim();
            if (username.isBlank()) {
                JOptionPane.showMessageDialog(this,
                        "Digite um username antes de jogar.",
                        "Campo obrigatório",
                        JOptionPane.WARNING_MESSAGE);
                return;
            }

            JOptionPane.showMessageDialog(this,
                    "Launcher pronto! Username selecionado: " + username,
                    "Jogar",
                    JOptionPane.INFORMATION_MESSAGE);
        });

        overlay.add(logoLabel);
        overlay.add(Box.createVerticalGlue());
        overlay.add(usernameField);
        overlay.add(Box.createRigidArea(new Dimension(0, 12)));
        overlay.add(playButton);
        overlay.add(Box.createRigidArea(new Dimension(0, 14)));
        overlay.add(versionLabel);

        content.add(overlay, BorderLayout.CENTER);
    }

    private JLabel createLogoLabel(String path) {
        File logoFile = new File(path);
        if (logoFile.exists()) {
            ImageIcon icon = new ImageIcon(path);
            Image scaled = icon.getImage().getScaledInstance(340, 140, Image.SCALE_SMOOTH);
            return new JLabel(new ImageIcon(scaled));
        }

        JLabel fallback = new JLabel("MINECRAFT");
        fallback.setForeground(Color.WHITE);
        fallback.setFont(new Font("SansSerif", Font.BOLD, 52));
        return fallback;
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            MinecraftLauncher launcher = new MinecraftLauncher();
            launcher.setVisible(true);
        });
    }

    private static class BackgroundPanel extends JPanel {
        private final Image backgroundImage;

        public BackgroundPanel(String path) {
            File backgroundFile = new File(path);
            if (backgroundFile.exists()) {
                backgroundImage = new ImageIcon(path).getImage();
            } else {
                backgroundImage = null;
            }
        }

        @Override
        protected void paintComponent(Graphics g) {
            super.paintComponent(g);

            if (backgroundImage != null) {
                g.drawImage(backgroundImage, 0, 0, getWidth(), getHeight(), this);
            } else {
                Graphics2D g2d = (Graphics2D) g;
                GradientPaint gradient = new GradientPaint(
                        0, 0, new Color(20, 24, 33),
                        0, getHeight(), new Color(54, 74, 44)
                );
                g2d.setPaint(gradient);
                g2d.fillRect(0, 0, getWidth(), getHeight());
            }
        }
    }
}
