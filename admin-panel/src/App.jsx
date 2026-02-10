import DashboardPage from './pages/DashboardPage';
import UsersPage from './pages/UsersPage';
import { isFirebaseConfigured, missingFirebaseKeys } from './firebase';

export default function App() {
  return (
    <main style={{ fontFamily: 'Inter, sans-serif', margin: '2rem' }}>
      <h1>Spark Admin Panel</h1>
      <p>Admin dashboard for Spark Dating users, matches, and analytics.</p>

      {!isFirebaseConfigured && (
        <p style={{ color: '#b42318' }}>
          Firebase env vars are missing: {missingFirebaseKeys.join(', ')}.
          <br />
          Add them in your hosting provider (Vercel/Railway) before expecting live data.
        </p>
      )}

      <DashboardPage />
      <UsersPage />
    </main>
  );
}
