import DashboardPage from './pages/DashboardPage';
import UsersPage from './pages/UsersPage';
import { isFirebaseConfigured, missingFirebaseKeys } from './firebase';

export default function App() {
  return (
    <main className="container">
      <section className="hero">
        <h1>✨ Spark Admin Panel</h1>
        <p>Manage users, monitor daily activity, and track matching growth in real-time.</p>
      </section>

      {!isFirebaseConfigured && (
        <p className="warning">
          Firebase env vars are missing: {missingFirebaseKeys.join(', ')}.
          <br />
          Add them in Vercel/Railway project settings for live production data.
        </p>
      )}

      <DashboardPage />
      <UsersPage />
    </main>
  );
}
