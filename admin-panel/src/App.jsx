import DashboardPage from './pages/DashboardPage';
import UsersPage from './pages/UsersPage';

export default function App() {
  return (
    <main style={{ fontFamily: 'Inter, sans-serif', margin: '2rem' }}>
      <h1>Spark Admin Panel</h1>
      <p>Starter dashboard for managing Spark Dating users and analytics.</p>
      <DashboardPage />
      <UsersPage />
    </main>
  );
}
